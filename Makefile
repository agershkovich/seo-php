CONTAINERNAME?=app
IMAGENAME?=seo-php-app
LOCALPATH?=$(shell pwd)
WEBPATH?=/www
PORT?=80

all:docker-build-seo-php-app docker-run-seo-php-app

delete:docker-stop docker-remove

docker-build-seo-php-app:
	docker build -t $(IMAGENAME) -f app.Dockerfile .

docker-run-seo-php-app:
	docker run -d -p $(PORT):80 -v $(LOCALPATH)$(WEBPATH):/var/www/site --name $(CONTAINERNAME) $(IMAGENAME)

docker-stop:
	docker stop $(CONTAINERNAME)

docker-remove:
	docker rm $(CONTAINERNAME)