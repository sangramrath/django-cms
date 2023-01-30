# This script install Docker / Docker Compose and runs Django CMS
#!/bin/sh
apt update -y
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
groupadd docker
usermod -aG docker $USER
# Clone django cms quickstart
cd
git clone https://github.com/django-cms/django-cms-quickstart.git
cd django-cms-quickstart
docker-compose build web
docker-compose up -d database_default
docker-compose run web python manage.py migrate
docker-compose run web python manage.py createsuperuser
docker-compose up -d
