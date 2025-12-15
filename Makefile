COMPOSE_FILE= ./srcs/docker-compose.yml

PROJECT_NAME= inception

up:
	sudo mkdir -p /home/${shell whoami}/data/db_data
	sudo mkdir -p /home/${shell whoami}/data/wp_data
	sudo docker compose -f ${COMPOSE_FILE} -p ${PROJECT_NAME} up -d --build 

down:
	sudo docker-compose -f ${COMPOSE_FILE} -p ${PROJECT_NAME} down -v || true

re: down up

fclean:
	sudo rm -rf /home/${shell whoami}/data
	sudo docker stop $(shell sudo docker ps -qa)
	sudo docker rm $(shell sudo docker ps -qa)
	sudo docker rmi -f $(shell sudo docker images -qa)
	sudo docker volume rm $(shell sudo docker volume ls -q)
	- sudo docker network rm $(shell sudo docker network ls -q)

network:
	sudo docker network ls

db:
	sudo docker exec -it mariadb sh

