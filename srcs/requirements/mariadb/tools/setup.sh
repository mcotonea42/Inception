#!/bin/bash

# Le script officiel utilisé par l'image de MariaDB :
# https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh


if [ ! -d "/var/lib/mysql/mysql" ]; then

    echo "Base de données MariaDB non trouvée. Lancement de l'initialisation..."
    
    # On donne les bonnes permissions au volume (car 'chown' dans le Dockerfile
    # ne fonctionne pas sur le volume monté)
    chown -R mysql:mysql /var/lib/mysql
    
    # Exécute le script d'installation qui crée la base 'mysql'
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    echo "Initialisation terminée."
else
    echo "Base de données MariaDB trouvée. Démarrage normal."
fi


# On lance mysqld en arrière plan afin de pouvoir lui envoyer toutes les commandes
# de configuration.
mysqld_safe &

until mysqladmin ping -h localhost; do
    sleep 2
done

mysql -u root << EOF

# L'utilisateur root n'a le droit de se connecter que depuis de 'localhost'
# c'est à dire depuis l'intérieur du conteneur. Le root n'est donc pas accessible
# via le réseau. 
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';


# On crée la base de donnée si elle n'existe pas.
# Les backticks (\`...\`) protégent le nom de la base de données.
CREATE DATABASE IF NOT EXISTS    \`${MARIADB_DATABASE}\`;

# On crée l'utilisateur si il n'existe pas.
# Le '%' est un joker qui signifie "de n'importe quelle IP".
# Un conteneur à sa propre IP sur le réseau Docker.
CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';

# Donne toutes les permissions à l'utilisateur que nous venons de créer,
# mais uniquement sur la base de donnée wordpress.
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%';

CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'localhost';


# Force MariaDB à recharger ses tables de permissions internes.
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} shutdown

exec mysqld_safe

# On utilise des quotes simples (') pour les chaînes de caractères.
# On utilise les backticks (`) pour les identifiants (noms de base de données, noms de tables...)