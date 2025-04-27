version: "3.8"

services:
  # (your mysql cluster services here...)

  wordpress-db:
    image: mysql:8.0
    hostname: wordpress-db
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpressuser
      MYSQL_PASSWORD: wordpresspass
    networks:
      - mysql_cluster_net
    volumes:
      - wordpress_db_data:/var/lib/mysql
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == worker]

  wordpress:
    image: wordpress:latest
    hostname: wordpress
    environment:
      WORDPRESS_DB_HOST: wordpress-db:3306
      WORDPRESS_DB_USER: wordpressuser
      WORDPRESS_DB_PASSWORD: wordpresspass
      WORDPRESS_DB_NAME: wordpress
    ports:
      - "8080:80"
    networks:
      - mysql_cluster_net
    depends_on:
      - wordpress-db
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == worker]

volumes:
  wordpress_db_data:

networks:
  mysql_cluster_net:
    external: true
