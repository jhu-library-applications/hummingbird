# hummingbird
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/jhu-library-applications/hummingbird/CI) [![codecov](https://codecov.io/gh/jhu-library-applications/hummingbird/branch/main/graph/badge.svg?token=YA5Z4VHIIH)](https://codecov.io/gh/jhu-library-applications/hummingbird)

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

# Resetting Database on Local Instance
If you are testing on a local instance and create records in the database, you will want to delete them before testing a newer version that changes the DB schema. Your old records may be in violation of rules in the new version of the DB. 

Delete existing local DB
```
docker-compose run hummingbird rake db:drop
```

Setting up database again
```
docker-compose run --rm hummingbird bundle exec rails db:migrate
```

Then run the "make" command as above.
# Seeding the database

To seed the database with the data located in `test_data`, run the following command:

`docker-compose run --rm hummingbird bundle exec rails db:seed`

This command will destory existing database entries and seed the database with the data in `test_data`.

