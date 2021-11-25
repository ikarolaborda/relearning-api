CONTAINER_NAME=api-relearning

docker-install:
	make docker-build
	make docker-up
	make docker-composer-install
	make docker-migrate
	make docker-clear

docker-up:
	docker-compose up -d

docker-update-env-vars:
	docker run --rm --workdir /app -v ${PWD}:/app node:15.14.0-alpine3.10 npm config set user 0 && npx envault --constructive --force --yes

docker-down:
	docker-compose down

docker-bash:
	make docker-up
	docker exec -it $(CONTAINER_NAME) sh

docker-build:
	docker-compose build

docker-composer-install:
	docker exec $(CONTAINER_NAME) composer install --no-interaction --no-scripts

docker-test:
ifdef FILTER
	make docker-up
	make docker-clear
	docker exec -t $(CONTAINER_NAME) composer unit-test -- --filter="$(FILTER)"
else
	make docker-up
	make docker-clear
	docker exec -t $(CONTAINER_NAME) composer unit-test
endif

docker-logs:
	docker-compose logs --follow

docker-migrate:
	make docker-migrate-refresh
	make docker-migrate-refresh-test

docker-migrate-refresh:
	docker exec $(CONTAINER_NAME) php artisan engine:db:wipe --env=example
	docker exec $(CONTAINER_NAME) php -d memory_limit=-1 artisan migrate --env=example --seed

docker-migrate-refresh-test:
	docker exec $(CONTAINER_NAME) php artisan engine:db:wipe --env=test
	docker exec $(CONTAINER_NAME) php -d memory_limit=-1 artisan migrate --env=test

docker-clear:
	docker exec $(CONTAINER_NAME) sh -c "php artisan optimize:clear"

docker-coverage-html:
	make docker-up
	make docker-clear
	docker exec -t $(CONTAINER_NAME) composer test-coverage-html

docker-format: docker-up
	docker exec -t $(CONTAINER_NAME) composer format
