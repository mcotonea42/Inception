# Avant dernière version de Debian.
FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

# Création du répertoire pour stocker les certificats
RUN mkdir -p /etc/nginx/ssl

# Génération du certificat auto-signé (Self-signed certificate)
# req -x509       : Génère un certificat auto-signé (plutôt qu'une demande de signature)
# -nodes          : Pas de mot de passe pour la clé privée (nécessaire pour le démarrage auto)
# -out /.../crt   : Chemin de sortie du certificat
# -keyout /.../key: Chemin de sortie de la clé privée
# -subj "..."     : Pré-remplissage des informations (Pays, Ville, Org, Common Name, UID)
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=42/CN=mcotonea.42.fr/UID=mcotonea"

RUN mkdir -p /var/run/nginx

# Copie de ton fichier de configuration personnalisé vers le conteneur
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Modification des droits du dossier racine du site.
# Changement du propriétaire du dossier vers 'www-data' (l'utilisateur par défaut de Nginx).
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

# Lancement de NGINX.
# Le -g daemon off force NGINX à tourner en premier plan, sinon le conteneur Docker s'arrêterait 
# immédiatement après le lancement car Docker considère qu'un processus qui passe en arrière-plan a fini sa tâche.
CMD ["nginx", "-g", "daemon off;"]