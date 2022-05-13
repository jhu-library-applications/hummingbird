.PHONY: up
up:
	docker-compose build \
	&& docker-compose run --rm hummingbird bundle install -j2	\
	&& docker-compose run -e RAILS_ENV=development --rm hummingbird rails db:create  \
	&& docker-compose run -e RAILS_ENV=development --rm hummingbird rails db:migrate \
	&& docker-compose up -d \
	&& docker-compose run --rm hummingbird rails tailwindcss:watch

.PHONY: test
test:
	docker-compose build \
	&& docker-compose run --rm hummingbird bundle install -j2	\
	&& docker-compose run -e RAILS_ENV=test --rm hummingbird bundle exec rails db:create  \
	&& docker-compose run -e RAILS_ENV=test --rm hummingbird bundle exec rails db:migrate \
	&& docker-compose run -e RAILS_ENV=test --rm hummingbird bundle exec rubocop \
	&& docker-compose run -e RAILS_ENV=test -e RUBYOPT='-W0' --rm hummingbird bundle exec rails spec
