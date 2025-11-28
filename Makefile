COMPOSE_FILE = srcs/docker-compose.yml

all:
	@echo "Lancement des services..."
	@mkdir -p /home/mcotonea/data/db_data
	@mkdir -p /home/mcotonea/data/wp_files
	@docker compose -f $(COMPOSE_FILE) up --build -d

down:
	@echo "Arrêt des services..."
	@docker compose -f $(COMPOSE_FILE) down

clean:
	@echo "Nettoyage complet (conteneurs + volumes)..."
	@docker compose -f $(COMPOSE_FILE) down -v
	@sudo rm -rf /home/mcotonea/data/db_data/*
	@sudo rm -rf /home/mcotonea/data/wp_files/*


re: clean all

.PHONY: all down clean re