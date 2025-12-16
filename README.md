*This project has been created as part of the 42 curriculum by rothiery.*

---

# Inception

## Description

### Project Overview
The Inception project consists of setting up a small containerized infrastructure using Docker and Docker Compose.  
It involves deploying multiple services, each running in its own dedicated container, and configuring their interactions through a Docker network.  
The infrastructure is designed to be modular, isolated, and reproducible, following the constraints defined in the project subject.

This project focuses on building a functional multi-service environment using containerization technologies.

### Goals

The main objectives of this project are:
- Learn how to build and configure Docker images
- Understand container lifecycle and isolation
- Orchestrate multiple services using Docker Compose
- Design a clean and maintainable container-based architecture
- Apply best practices for service communication and security

---

## Project Description & Design Choices

### Use of Docker
Docker is used to containerize the three main services in this project: MariaDB, WordPress, and Nginx.  
Each service runs in its own container, ensuring isolation and independent management. The containers are orchestrated using Docker Compose, allowing for easy deployment and management of the multi-container environment.

The use of Docker Compose allows the services to be defined in a single configuration file (`docker-compose.yml`), making the project reproducible and scalable. Docker networks ensure communication between containers using service names, while persistent data is stored using Docker volumes, ensuring data integrity and durability.

### Project Sources

The project relies on official Docker images for MariaDB and WordPress, with custom configuration provided via `Dockerfile` and environment variables defined in a `.env` file.  
The custom Nginx image is also built from a `Dockerfile` located in the `requirements/nginx` directory. Nginx is configured to serve the WordPress application over HTTPS, as required by the project.

All images are built using the Alpine Linux base image to ensure a lightweight and secure environment.

### Main Design Choices

- **Custom Docker Bridge Network**: A custom Docker bridge network named `networkInception` is used to enable communication between all services.  
  This design choice ensures secure communication between containers while maintaining network isolation and complying with project requirements.
  
- **Persistent Data**: Data for MariaDB and WordPress is stored in bind mounts on the host machine.  
  These bind mounts are declared as Docker volumes (`db_data` and `wp_data`) in `docker-compose.yml` but point to specific directories on the host (`/home/<login>/data/db_data` and `/home/<login>/data/wp_data`).  
  This ensures that all important data persists across container restarts, is accessible on the host, and complies with the project requirements.

- **Environment Variables**: Configuration for each service is managed using environment variables loaded from a `.env` file. This approach ensures that sensitive data such as database credentials are kept outside the codebase, improving security and flexibility.
  
- **TLS Configuration in Nginx**: As required by the project specifications, Nginx is configured to serve the WordPress site over HTTPS. The TLS configuration is handled by providing SSL certificates in the Nginx configuration, ensuring secure communication between users and the web server.

- **Alpine Linux Base Image**: All containers are based on the Alpine Linux image, known for its small size and security features. This choice ensures a minimal footprint for each service, reducing overhead and increasing performance.

---

## Comparisons

### Virtual Machines vs Docker

Virtual Machines virtualize an entire operating system, including the kernel, which results in higher resource usage and slower startup times.  
Docker, on the other hand, relies on containerization, sharing the host kernel while isolating applications at the process level. This makes containers lighter, faster to start, and easier to manage.

In this project, Docker is used to deploy and isolate services inside containers, while the entire infrastructure itself is hosted on an Ubuntu Virtual Machine, as required by the project subject.  
This setup combines the isolation benefits of a virtual machine with the efficiency and flexibility of Docker containers.

---

### Secrets vs Environment Variables

Docker secrets provide a secure way to manage sensitive data, but they require specific orchestration tools and are not allowed within the constraints of this project.  
Instead, environment variables are used to configure services and store sensitive information such as database credentials.

All environment variables are centralized in a `.env` file, which allows for easier configuration management while keeping secrets out of the source code.  
This approach respects the project requirements while maintaining a clear separation between configuration and application logic.

---

### Docker Network vs Host Network

Using the host network mode allows containers to share the host’s network stack, but it removes network isolation and is explicitly forbidden by the project subject, along with deprecated options such as `--links`.

For this reason, a custom Docker bridge network named `networkInception` is used.  
All containers are connected to this network, allowing them to communicate securely using service names while maintaining isolation from the host network.
This design improves isolation, security, and maintainability of the infrastructure.

---

### Docker Volumes vs Bind Mounts

Docker volumes are managed directly by Docker and provide an abstracted way to persist data.  
Bind mounts, on the other hand, map a specific directory from the host filesystem into a container.

In this project, bind mounts are used through volume declarations to store persistent data in `/home/<login>/data`, as required by the project subject.  
This choice ensures that data remains accessible on the host machine and persists independently of container lifecycle, while still being managed through Docker Compose.

Using bind mounts in this context provides greater control over data location and complies with the subject’s storage constraints.


---

## Instructions

### Prerequisites

Before running the project, ensure that Docker and Docker Compose are installed on your system.  
The project is designed to be run inside a virtual machine, as required by the subject. Ubuntu was used for testing, but any OS with Docker and Docker Compose should work.

### Installation

1. Clone the repository to your local machine or virtual machine.
2. Create your own .env file in the project root to store sensitive information.
   Here is an example of what it should contain:

   ```env
   # MariaDB
   SQL_DATABASE=wordpress
   SQL_USER=login
   SQL_PASSWORD=password
   SQL_ROOT_PASSWORD=password

   # WordPress
   WORDPRESS_URL=login.42.fr

   WORDPRESS_ADMIN_USER=login
   WORDPRESS_ADMIN_PASS=password
   WORDPRESS_ADMIN_EMAIL=login@student.42.fr

   WORDPRESS_USER=login_user
   WORDPRESS_USER_PASS=password
   WORDPRESS_USER_EMAIL=login_user@student.42.fr


---

## Usage

### Examples

Once the project is running (`make up`), you can access the WordPress site using your web browser at the URL defined in your `.env` file (`WORDPRESS_URL`) or `https://localhost` if testing locally.  

All services are served over HTTPS using Nginx, ensuring secure access to your WordPress site.

---

## Features

The Inception project includes the following key features:

- **MariaDB**: A containerized MySQL database service to store WordPress data securely.
- **WordPress**: A fully functional WordPress site running in its own container.
- **Nginx**: Serves the WordPress site over HTTPS with TLS, ensuring secure communication.
- **HTTPS support**: All web traffic is encrypted using TLS certificates configured in Nginx.
- **Container isolation**: Each service runs in its own container, ensuring modularity and security.
- **Persistent data**: Database and WordPress files are stored in bind mounts on the host (declared as Docker volumes) to maintain data across container restarts.
- **Configuration via .env**: All sensitive information and configuration options are managed through an `.env` file, keeping secrets out of the source code.
- **Automated build and deployment**: All services are built and deployed using a Makefile, simplifying project setup and management.

---

## Technical Choices

- **Alpine Linux Base Images**: All custom Docker images are based on Alpine Linux, providing a minimal, lightweight, and secure environment.

- **Containerization & Isolation**: Each service runs in its own container to ensure modularity, easier management, and better security.  

- **Persistent Data via Bind Mounts**: MariaDB and WordPress data are stored in bind mounts on the host (declared as Docker volumes in `docker-compose.yml`) to maintain persistence across container restarts.  

- **Custom Docker Bridge Network**: A dedicated network (`networkInception`) allows secure communication between containers while maintaining isolation from the host network.  

- **HTTPS / TLS**: Nginx serves WordPress over HTTPS, ensuring secure communication between the web server and clients.  

- **Environment Variables**: All sensitive data and configuration options are managed via a `.env` file, keeping secrets out of the code and enabling easy reconfiguration.

---

## Resources

### Documentation & References

The following resources were used during the development of this project:

- **Docker Documentation**: https://docs.docker.com/  
  For understanding Docker containers, Docker Compose, volumes, networks, and best practices.

- **WordPress Documentation**: https://wordpress.org/support/  
  For configuring and deploying WordPress in a containerized environment.

- **Nginx Documentation**: https://nginx.org/en/docs/  
  For configuring the web server, enabling HTTPS, and managing reverse proxy settings.

- **MariaDB Documentation**: https://mariadb.com/kb/en/  
  For database configuration, user management, and persistence in containers.

These references were essential to ensure that the project followed best practices for containerization, networking, and secure deployment.

### AI Usage

Artificial Intelligence tools were used to assist in the following tasks:

- **Structuring the README**: Generating an organized template and ensuring clear separation of sections.  
- **Drafting technical explanations**: Clarifying Docker, network, and persistence concepts.  
- **Ensuring proper English language and readability**: Improving phrasing and clarity without changing the technical content.

AI was used as a guide and helper only; all code, configuration files, and technical decisions were made independently by myself.