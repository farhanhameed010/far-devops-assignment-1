#!/bin/bash
set -e 
# Initialize variables
Docker_Version="5:25.0.3-1~ubuntu.22.04~jammy" 
Docker_Compose_Version="v2.24.7" 

echo "------>>>>>> Installing Docker and Docker Compose <<<<<<------" 

# Add Docker's official GPG key:

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce=${Docker_Version} docker-ce-cli=${Docker_Version} containerd.io docker-buildx-plugin

echo "------>>>>>> Docker version ${Docker_Version} Installation Completed. <<<<<<------"

# Start Docker service and enable it to start on boot
echo "------>>>>>> Starting Docker service and enabling it to start on boot <<<<<<------"
sudo systemctl start docker
sudo systemctl enable docker
echo "------>>>>>> Docker service is enabled to start on boot. <<<<<<------"

# Echo current status of Docker service
echo "------>>>>>> Verifying Docker service status <<<<<<------"
sudo systemctl status docker --no-pager | grep "Active"

# Wait
sleep 5

# Add logged in user to Docker group
echo "------>>>>>> Adding $(whoami) to the Docker group <<<<<<------"
sudo usermod -aG docker $(whoami)

# Inform user to log out and log back in
echo "Please log out and log back in to apply the Docker group changes and ensure Docker starts on boot."

# Wait
sleep 5

echo "------>>>>>> Installing Docker-Compose <<<<<<------"
sudo curl -L "https://github.com/docker/compose/releases/download/${Docker_Compose_Version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
echo "------>>>>>> Docker-Compose Installation Completed. <<<<<<------"

echo "===> Installed Docker version:"
docker --version
echo "===> Installed Docker Compose version:"
docker compose version