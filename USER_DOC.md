# User documentation

## services

### 1. Mariabd
- MariaDB is the database server used by WordPress to store all site data, such as:
- Posts and pages
- Users and passwords
- Configuration options
- Plugins and themes data

### 2. WordPress
- This is the actual WordPress application — the PHP code that generates the website. It handles:
- Generating the website pages
- Communicating with the database
- Managing users, themes, and plugins

### 3. Nginx
- Nginx is the frontend web server.
- It serves all the web pages to visitors and forwards PHP requests to the WordPress container. Responsibilities:
- Serves static files (images, CSS, JS)
- Handles HTTPS on port 443
- Passes PHP processing to the WordPress container

### 4. Volumes
- Two persistent volumes ensure data survives container restarts:
- db_data → Database storage
- wp_data → WordPress files and uploads

### 5. Network
- All containers communicate through a private Docker network:
- NetworkInception
- Using Bridge

## Start and stop the project

### 1. Start
- bash <vm>.sh
- git clone project
- add .env in srcs/
- make up

### 2. Stop
- make fclean
- close the vm

## website

### 1. Access the website
- after starting the project
- search localhost or login.42.fr

### 2. Access administration panel
- Change the ?p=1 at the end of the url to wp-admin
- Then look in the .env for WORDPRESS_ADMIN_USER and WORDPRESS_ADMIN_PASS to connect as admin

## Locate and manage credentials

### Find .env
- .env should be in srcs/ next to docker-compose.yml

### Manage
- Change values in SQL_... for mariabd
- WORDPRESS_URL is the url of the website
- WORDPRESS_ADMIN_... to change admin variables
- WORDPRESS_... to change user variables

## Check that the services are running correctly

### How to check dockers runnings
- Check if the Dockers are runing with: docker ps -a (add sudo if you dont have perms)
