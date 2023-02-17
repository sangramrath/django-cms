#!/bin/sh
apt update -y
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
git clone https://github.com/django-cms/django-cms-quickstart.git ~/django-cms-quickstart
cd ~/django-cms-quickstart
sed -i '$ a DJANGO_SUPERUSER_PASSWORD=admin' .env-local
docker-compose build web
docker-compose up -d database_default
docker-compose run web python manage.py migrate
docker-compose run web python manage.py createsuperuser --noinput --username admin --email admin@djangocms.local
docker-compose up -d
