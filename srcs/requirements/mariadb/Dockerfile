# Avant dernière version de Debian.
FROM debian:bookworm

# La directive RUN exécute des commandes shell dans l'image.
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# Permet de copier notre fichier de configuration personnalisé dans le dossier de configuration de MariaDB.
# Permet à MariaDB d'écouter sur toutes les interfaces réseau (0.0.0.0) et pas seulement localhost. 
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Permet de copier notre script dans un dossier du $PATH du conteneur, ce qui
# rend le script 'setup.sh' globalement exécutable
COPY ./tools/setup.sh /usr/local/bin/setup.sh

# Par défaut, les fichiers copiés n'ont pas la permission d'éxécution.
RUN chmod +x /usr/local/bin/setup.sh

# Permet d'informer Docker que le conteneur écoutera sur ce port.
# 3306 est le port par défaut de MariaDB.
EXPOSE 3306

# Permet de définir la commande par défaut du conteneur (PID 1).
# PID 1 est le premier processus lancé par un conteneur: il est responsable de gérer
# tous les autres processus "enfants" et de recevoir les signaux d'arrêts pour s'éteindre correctement.
CMD ["/usr/local/bin/setup.sh"]