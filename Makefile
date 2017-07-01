APPCONTAINERNAME?=app
APPIMAGENAME?=seo-php-app
TESTCONTAINERNAME?=selenium-firefox
TESTIMAGENAME?=selenium/standalone-firefox-debug
TESTBROWSER?=firefox
LOCALPATH?=$(shell pwd)
WEBPATH?=/www
STEWARD?=/selenium-tests/vendor/bin/steward
APPPORT?=80
TESTPORT?=4444
VNCTESTPORT?=5900
ISOLATEDNETWORK?=app-selenium-nw


all:docker-build-seo-php-app docker-run-seo-php-app runtest results delete

delete:docker-stop docker-remove

docker-build-seo-php-app:
	docker build -t $(APPIMAGENAME) -f app.Dockerfile .

docker-run-seo-php-app:
	docker network create --driver bridge $(ISOLATEDNETWORK)
	docker run -d --health-cmd='curl -f http://localhost/ || exit 1' --health-interval=1s --health-retries=5 -p $(APPPORT):80 --network=$(ISOLATEDNETWORK) -v $(LOCALPATH)$(WEBPATH):/var/www/site --name $(APPCONTAINERNAME) $(APPIMAGENAME)
	docker run -d --health-cmd='curl -f http://localhost:4444/ || exit 1' --health-interval=1s --health-retries=5 -p $(TESTPORT):4444 -p $(VNCTESTPORT):5900 --network=$(ISOLATEDNETWORK) --shm-size 2g --name $(TESTCONTAINERNAME) $(TESTIMAGENAME)

docker-stop:
	docker stop $(APPCONTAINERNAME)
	docker stop $(TESTCONTAINERNAME)

docker-remove:
	docker rm $(APPCONTAINERNAME)
	docker rm $(TESTCONTAINERNAME)
	docker network rm $(ISOLATEDNETWORK)

runtest:
	sleep 1
	$(LOCALPATH)$(STEWARD) run staging $(TESTBROWSER) -vvv

results:
	$(LOCALPATH)$(STEWARD) results
