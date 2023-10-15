#!/bin/bash

# Make sure old versions of Docker are not present on the system
apt-get remove docker docker-engine docker.io containerd runc

# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# docker run hello-world

apt-get install -y docker-compose-plugin
docker compose version

if [ ! -e "/home/ubuntu/php-mysql-crud-docker" ]; then
  mkdir /home/ubuntu/php-mysql-crud-docker
fi
  
if [ ! -e "/home/ubuntu/php-mysql-crud-docker/src" ]; then
  git clone https://github.com/FaztWeb/php-mysql-crud /home/ubuntu/php-mysql-crud-docker/src
  echo "+++Git repository cloned successfully"

else
    echo "+++Directory '/home/ubuntu/php-mysql-crud-docker/src' already exists"

fi