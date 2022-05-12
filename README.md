# hummingbird
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/jhu-library-applications/hummingbird/CI)

A Rails application for managing the Database A-Z list.

# Instructions for running the application

1. Install Docker Desktop if you are using a Mac or PC. 
2. Run the following commands to install the dependencies and create the initial database.

## Run with the Makefile

To run the server with the Makefile, run the following command:

```
make up 
```

To run the specs, run the following command:

```
make test
```

## Run using docker-compose directly

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
