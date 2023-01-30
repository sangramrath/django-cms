# This script install Docker / Docker Compose and runs Django CMS
#!/bin/sh
apt update -y
apt install -y docker.io docker-compose
#curl -SL https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
#ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Clone django cms quickstart
git clone https://github.com/django-cms/django-cms-quickstart.git
cd django-cms-quickstart
docker compose build web
docker compose up -d database_default
docker compose run web python manage.py migrate
docker compose run web python manage.py createsuperuser
docker compose up -d
