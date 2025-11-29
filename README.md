# 🚀 Inception - Docker WordPress/MariaDB/Nginx Project

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-%230D597F.svg?style=for-the-badge&logo=alpine-linux&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![42 School](https://img.shields.io/badge/School-42-000000?style=for-the-badge&logo=42&logoColor=white)

> ⚠️ **Prerequisites:**
> - Docker must be installed on your machine ([see official documentation](https://docs.docker.com/get-docker/))
> - This project was designed to run on **Linux** (or VM)

Welcome to **Inception**! This project allows you to deploy a secure WordPress site with MariaDB and Nginx, all orchestrated via Docker Compose.

---

## 🗂️ Project Structure

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

- **MariaDB**: Database for WordPress
- **WordPress**: CMS automatically installed and configured
- **Nginx**: Secure web server with a self-signed SSL certificate

---

## ⚙️ Installation & Usage

1. **Configure Environment Variables**

	 Create a `.env` file in the `srcs` folder and fill in the values (see `.env_sample` if available).

2. **Modify your hosts file**
	- Add the following line to `/etc/hosts` to map the domain to localhost:
	  ```
	  127.0.0.1   mcotonea.42.fr
	  ```

3. **Start the services**
	 ```zsh
	 make
	 ```

4. **Access your site**
	- Open [https://mcotonea.42.fr](https://mcotonea.42.fr) (or the domain you defined in `.env`)

---

## 🛠️ Useful Commands

- **Stop services**
	```zsh
	make down
	```
- **Clean everything (containers + volumes)**
	```zsh
	make clean
	```
- **Full Rebuild**
	```zsh
	make re
	```

---

## 🔒 Security

- Secure HTTPS access (self-signed certificate)
- Passwords and users are defined via the `.env` file

---

## 📦 Persistent Volumes

Data is stored in:
- `/home/mcotonea/data/db_data`: MariaDB database
- `/home/mcotonea/data/wp_files`: WordPress files

---

## 👤 Author

This project was built by:

* **COTONEA Melvin** - [View GitHub Profile](https://github.com/mcotonea42)