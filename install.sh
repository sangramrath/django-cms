# This script install Docker / Docker Compose and runs Django CMS
#!/bin/sh
apt update -y
apt install -y docker.io docker-compose
# Clone django cms quickstart
git clone https://github.com/django-cms/django-cms-quickstart.git
cd django-cms-quickstart
docker-compose build web
docker-compose up -d database_default
docker-compose run web python manage.py migrate
docker-compose run web python manage.py createsuperuser
docker-compose up -d
