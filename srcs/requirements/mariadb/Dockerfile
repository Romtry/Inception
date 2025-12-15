FROM alpine:3.22

EXPOSE	3306

# Install MariaDB
RUN		apk update && apk upgrade && apk add --no-cache \
			mariadb \
			mariadb-client

RUN		mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY tools/my.cnf etc/my.cnf
COPY tools/entrypoint.sh etc/entrypoint.sh

RUN     chmod +x etc/entrypoint.sh

ENTRYPOINT ["sh", "etc/entrypoint.sh"]