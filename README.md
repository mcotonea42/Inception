
# 🚀 Inception - Projet Docker WordPress/MariaDB/Nginx

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-%230D597F.svg?style=for-the-badge&logo=alpine-linux&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![42 School](https://img.shields.io/badge/School-42-000000?style=for-the-badge&logo=42&logoColor=white)

> ⚠️ **Prérequis :**
> - Docker doit être installé sur votre PC ([voir la documentation officielle](https://docs.docker.com/get-docker/))
> - Ce projet a été conçu pour tourner sous **Linux** (ou VM)

Bienvenue sur **Inception** ! Ce projet te permet de déployer un site WordPress sécurisé avec MariaDB et Nginx, le tout orchestré avec Docker Compose.  

---

## 🗂️ Structure du projet

```
Makefile
srcs/
	docker-compose.yml
	requirements/
		mariadb/
			Dockerfile
			conf/
				50-server.cnf
			tools/
				setup.sh
		nginx/
			Dockerfile
			conf/
				nginx.conf
		wordpress/
			Dockerfile
			conf/
				www.conf
			tools/
				setup.sh
```

- **MariaDB** : Base de données pour WordPress
- **WordPress** : CMS installé et configuré automatiquement
- **Nginx** : Serveur web sécurisé avec certificat SSL auto-signé

---

## ⚙️ Installation & Lancement

1. **Configure les variables d’environnement**

	 Crée un fichier `.env` dans le dossier srcs et renseigne les valeurs (exemple dans `.env_sample` si présent).

2. **Modifie ton fichier hosts**
	- Ajoute cette ligne dans `/etc/hosts` pour faire pointer le domaine vers localhost :
	  ```
	  127.0.0.1   mcotonea.42.fr
	  ```

3. **Lance les services**
	 ```zsh
	 make
	 ```

4. **Accède à ton site**
	- Ouvre [https://mcotonea.42.fr](https://mcotonea.42.fr) (ou le domaine que tu as mis dans `.env`)

---

## 🛠️ Commandes utiles

- **Arrêter les services**
	```zsh
	make down
	```
- **Nettoyer tout (conteneurs + volumes)**
	```zsh
	make clean
	```
- **Rebuild complet**
	```zsh
	make re
	```

---

## 🔒 Sécurité

- Accès sécurisé en HTTPS (certificat auto-signé)
- Les mots de passe et utilisateurs sont définis via le fichier `.env`

---

## 📦 Volumes persistants

Les données sont sauvegardées dans :
- `/home/mcotonea/data/db_data` : Base de données MariaDB
- `/home/mcotonea/data/wp_files` : Fichiers WordPress

---

## 👤 Auteur

Ce projet a été réalisé par :

* **COTONEA Melvin** - [Voir le profil GitHub](https://github.com/mcotonea42)