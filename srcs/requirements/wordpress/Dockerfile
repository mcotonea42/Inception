# Avant dernière version de Debian.
FROM debian:bookworm

# Installe php-fpm: le moteur PHP, php-mysql pour que PHP puisse parler à MariaDB
# et curl pour télécharger wp-cli.
RUN apt-get update && \
    apt-get install -y php-fpm php-mysql curl mariadb-client libfcgi-bin 

RUN apt-get update && apt-get install -y netcat-openbsd

# https://www.hostinger.com/fr/tutoriels/wp-cli
# Installe l'outil WP-CLI permettant de gérer le site WordPress depuis les lignes de commandes
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# On copie notre script qui installe Wordpress et lancer php-fpm.
# On le rend exécutable.
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# On expose le port sur lequel Nginx communiquera avec php-fpm.
EXPOSE 9000

# On lance le script qui lancera php-fpm au premier plan (PID1).
CMD ["/usr/local/bin/setup.sh"]