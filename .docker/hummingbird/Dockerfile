FROM ruby:3-alpine as builder

RUN apk update && apk add --no-cache \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  tzdata \
  shared-mime-info

RUN mkdir -p /hummingbird
WORKDIR /hummingbird

RUN gem install bundler --no-document

EXPOSE 3000

CMD sh -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
