#!/bin/bash

# https://www.hostinger.com/fr/tutoriels/wp-cli

# On doit verifier que MariaDB soit pret avant de lancer Wordpress, sinon ca plante.
# on boucle tant que mysqladmin ping echoue.
until mysqladmin ping -h mariadb -u${MARIADB_USER} -p${MARIADB_PASSWORD} --skip-ssl; do
    echo "MariaDB n'est pas encore prêt..."
    sleep 2
done

echo "MariaDB est prêt. Lancement de la configuration de Wordpress."

# On vérifie si wp-config.php existe déjà.
# Si OUI : On ne fait rien (le site est déjà installé, on redémarre juste le conteneur).
# Si NON : On lance l'installation initiale.
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress non trouvé. Lancement de la nouvelle installation..."
    
    cd /var/www/html

    # Téléchargement des fichiers cœurs de WordPress via WP-CLI
    wp core download --allow-root

    # Création du fichier wp-config.php
    # Connecte PHP à la base de données MariaDB
    wp config create --allow-root \
        --dbname=${MARIADB_DATABASE} \
        --dbuser=${MARIADB_USER} \
        --dbpass=${MARIADB_PASSWORD} \
        --dbhost=mariadb

    # Installation de la BDD (Création des tables + Compte Admin)
    # C'est ici que le titre du site et l'admin sont définis.
    wp core install --allow-root \
        --url=${DOMAIN_NAME} \
        --title="Inception" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email="test@test.fr"
    
    # Création du second utilisateur (requis par le sujet)
    # Role author : peut écrire des articles mais pas toucher à la config
    wp user create --allow-root \
        corrector corrector@test.fr \
        --role=author \
        --user_pass=corrector

    echo "Installation de WordPress terminée."

    chown -R www-data:www-data /var/www/html

else
    echo "WordPress est déjà installé."
fi

echo "Lancement de PHP-FPM au premier plan..."
# PHP-FPM devient le PID 1 et de recevoir les signaux. 
# On le force au premier plan, sinon le conteneur s'arrete.
exec /usr/sbin/php-fpm8.2 -F