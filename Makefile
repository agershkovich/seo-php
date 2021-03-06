APPCONTAINERNAME?=app.int
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

all:setup docker-build-seo-php-app docker-run-seo-php-app runtests results delete

.ONESHELL:
setup:
	cd selenium-tests/;
	composer require lmc/steward

delete:kill-selenium docker-stop docker-remove

docker-build-seo-php-app:
	docker build -t $(APPIMAGENAME) .

docker-run-seo-php-app:
	docker run -d --health-cmd='curl -f http://localhost/ || exit 1' --health-interval=1s --health-retries=5 -p $(APPPORT):80 -v $(LOCALPATH)$(WEBPATH):/var/www/site --name $(APPCONTAINERNAME) $(APPIMAGENAME)
	docker run -d --health-cmd='curl -f http://localhost:4444/ || exit 1' --health-interval=1s --health-retries=5 -p $(TESTPORT):4444 -p $(VNCTESTPORT):5900 --shm-size 2g --name $(TESTCONTAINERNAME) $(TESTIMAGENAME)

docker-stop:
	docker stop $(APPCONTAINERNAME)

docker-remove:
	docker rm $(APPCONTAINERNAME)
	docker rm $(TESTCONTAINERNAME)

runtests:
	sleep 1
	$(LOCALPATH)$(STEWARD) run staging $(TESTBROWSER) -vvv

results:
	$(LOCALPATH)$(STEWARD) results

kill-selenium:
	pkill -f selenium &>/dev/null