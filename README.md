# relearning-api
A simple Laravel CRUD with modern cloud techniques like docker and docker-compose

## Sequence of Commands

In order to get the application functioning properly, you must do the following

- ```docker-compose up -d --build```
- ```php artisan migrate```

### Important Notes

Before you can execute the `php artisan migrate` command, you must set your `.env` file to match the following:

```
LOG_CHANNEL=null
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=null

DB_CONNECTION=mysql
DB_HOST={DOCKER_DATABASE_IMAGE_NAMES_HERE}
DB_PORT=3306
DB_DATABASE=relearning
DB_USERNAME=root
DB_PASSWORD=root
```
