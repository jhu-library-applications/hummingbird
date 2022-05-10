# hummingbird

A Rails application for managing the Database A-Z list.


# Instructions for running the application

## Using docker-compose

```
docker-compose up --build
docker-compose run --rm hummingbird bundle 
docker-compose run --rm hummingbird bundle exec rails db:create
docker-compose run --rm hummingbird bundle exec rails db:migrate
docker-compose up
```

# Running the specs

```
docker-compose run --rm hummingbird bundle exec spec
```
