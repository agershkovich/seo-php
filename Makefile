APPCONTAINERNAME?=app.int
APPIMAGENAME?=seo-php-app
TESTBROWSER?=firefox
LOCALPATH?=$(shell pwd)
WEBPATH?=/www
STEWARD?=/selenium-tests/vendor/bin/steward
APPPORT?=80


all:setup docker-build-seo-php-app docker-run-seo-php-app runtests results delete

.ONESHELL:
setup:
	cd selenium-tests/;
	composer require lmc/steward
	./vendor/bin/steward install --no-interaction
	java -jar ./vendor/bin/selenium-server-standalone-3.4.0.jar &>/dev/null &


delete:docker-stop docker-remove

docker-build-seo-php-app:
	docker build -t $(APPIMAGENAME) .

docker-run-seo-php-app:
	docker run -d --health-cmd='curl -f http://localhost/ || exit 1' --health-interval=1s --health-retries=5 -p $(APPPORT):80 -v $(LOCALPATH)$(WEBPATH):/var/www/site --name $(APPCONTAINERNAME) $(APPIMAGENAME)

docker-stop:
	docker stop $(APPCONTAINERNAME)

docker-remove:
	docker rm $(APPCONTAINERNAME)

runtests:
	sleep 1
	$(LOCALPATH)$(STEWARD) run staging $(TESTBROWSER) -vvv

results:
	$(LOCALPATH)$(STEWARD) results
