#!/bin/bash
set -e

# Update and install Docker
echo "Installing Docker"
apt update -y
apt install docker.io -y
systemctl enable --now docker

# Create a Docker volume for Jenkins Home
echo "Creating Docker volume for Jenkins Home"
docker volume create jenkins-master-home

# Start Jenkins container with volume mounted
echo "Starting Jenkins container"
docker run -d --restart=always --name jenkins-master \
  -v jenkins-master-home:/var/jenkins_home \
  -p 8080:8080 -p 50000:50000 \
  jenkins/jenkins:lts

# Wait for the Jenkins container to start
echo "Waiting for the container to start"
sleep 10

# Fetch and print initial admin password
echo "Printing initial admin password"
docker exec jenkins-master bash -c 'cat /var/jenkins_home/secrets/initialAdminPassword'
