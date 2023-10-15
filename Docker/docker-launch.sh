#!/bin/bash

set -xv

PUBLIC_IP=34.207.217.200
KEY_PAIR=docker-task.pem
EC2_USER=ubuntu

scp -i $KEY_PAIR docker_env_install.sh "$EC2_USER"@"$PUBLIC_IP":/tmp/docker_env_install.sh

ssh -i $KEY_PAIR "$EC2_USER"@"$PUBLIC_IP" <<EOF
chmod +x /tmp/docker_env_install.sh
sudo bash /tmp/docker_env_install.sh
sudo chown -R ubuntu:ubuntu ~/php-mysql-crud-docker/
EOF

scp -i $KEY_PAIR db.php "$EC2_USER"@"$PUBLIC_IP":/home/ubuntu/php-mysql-crud-docker/src

scp -i $KEY_PAIR docker-compose.yaml \
                 Dockerfile \
                 .env\
                 "$EC2_USER"@"$PUBLIC_IP":/home/ubuntu/php-mysql-crud-docker

ssh -i $KEY_PAIR "$EC2_USER"@"$PUBLIC_IP" "sudo docker compose -f /home/ubuntu/php-mysql-crud-docker/docker-compose.yaml up -d"