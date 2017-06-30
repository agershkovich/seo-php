APPIMAGE?=seo-php-app
WEBPATH?=/home/agershkovich/IdeaProjects/seo-php/www
PORT?=80

all:docker-build-seo-php-app docker-run-seo-php-app

docker-build-seo-php-app:
	docker build -t $(APP) .

docker-run-seo-php-app:
	docker run -d -p $(PORT):80 -v $(WEBPATH):/var/www/site --name app $(APPIMAGE)