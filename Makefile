all:docker-build-seo-php-app docker-run-seo-php-app

docker-build-seo-php-app:
	docker build -t seo-php-app .

docker-run-seo-php-app:
	docker run -d -p 80:80 -v /home/agershkovich/IdeaProjects/seo-php/www:/var/www/site --name app seo-php-app