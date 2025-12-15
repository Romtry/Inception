# Dev documentation

## Set up the environment from scratch

### 1. Initiate
- Create a .env file in srcs next to docker-compose.yml
- Instantiate next values

### 2. MariaDB
- SQL_DATABASE=wordpress
- SQL_USER='user'
- SQL_PASSWORD='password'
- SQL_ROOT_PASSWORD='root password'

### 3. WordPress

#### 1. Admin part
- WORDPRESS_URL='login'.42.fr
- WORDPRESS_ADMIN_USER='login'
- WORDPRESS_ADMIN_PASS='admin password'
- WORDPRESS_ADMIN_EMAIL='login'@student.42.fr

#### 2. User part
- WORDPRESS_USER='login'_user
- WORDPRESS_USER_PASS='user password'
- WORDPRESS_USER_EMAIL='login'_user@student.42.fr

## Build and launch the project using the Makefile and Docker Compose
- make up

## Use relevant commands to manage the containers and volumes
- To see the networks: make network
- To enter mariabd: make db 

## Identify where the project data is stored and how it persists
- Data should be in /home/"login"/
