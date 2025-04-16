version: '3.8'

services:
  mysql-master:
    image: mysql:8.0
    secrets:
      - mysql_root_password
      - mysql_repl_password
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/mysql_root_password
      MYSQL_REPLICATION_USER: replicator
      MYSQL_REPLICATION_PASSWORD_FILE: /run/secrets/mysql_repl_password
      MYSQL_DATABASE: app_db
    networks:
      - mysql_net
    ports:
      - "3306:3306"
    volumes:
      - mysql_master_data:/var/lib/mysql
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == manager]

secrets:
  mysql_root_password:
    external: true
  mysql_repl_password:
    external: true

volumes:
  mysql_master_data:

networks:
  mysql_net:
    external: true
