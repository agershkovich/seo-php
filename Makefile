APPCONTAINERNAME?=app
APPIMAGENAME?=seo-php-app
TESTCONTAINERNAME?=firefox
TESTIMAGENAME?=selenium/standalone-firefox-debug
LOCALPATH?=$(shell pwd)
WEBPATH?=/www
APPPORT?=80
TESTPORT?=4444
VNCTESTPORT?=5900


all:docker-build-seo-php-app docker-run-seo-php-app

delete:docker-stop docker-remove

docker-build-seo-php-app:
	docker build -t $(APPIMAGENAME) -f app.Dockerfile .

docker-run-seo-php-app:
	docker run -d -p $(APPPORT):80 -v $(LOCALPATH)$(WEBPATH):/var/www/site --name $(APPCONTAINERNAME) $(APPIMAGENAME)
	docker run -p $(TESTPORT):4444 -p $(VNCTESTPORT):5900 --shm-size 2g --name $(TESTCONTAINERNAME) $(TESTIMAGENAME)

docker-stop:
	docker stop $(APPCONTAINERNAME)
	docker stop $(TESTCONTAINERNAME)

docker-remove:
	docker rm $(APPCONTAINERNAME)
	docker rm $(TESTCONTAINERNAME)