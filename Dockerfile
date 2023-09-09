FROM ruby:3.2.2-alpine

RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  ca-certificates \
  curl \
  git

ENV LC_ALL en_US.UTF-8
ARG LOCAL_TIME=America/Sao_Paulo
RUN update-ca-certificates
RUN ln -snf /usr/share/zoneinfo/$LOCAL_TIME \
  /etc/localtime

ARG APP_PATH=/app
WORKDIR $APP_PATH

COPY . $APP_PATH

RUN export BUNDLER_VERSION=$(awk '/BUNDLED WITH/ { getline ; print $1 }' Gemfile.lock) \
  && gem install bundler --version $BUNDLER_VERSION \
  && gem install brakeman \
  && bundle install -j4 --retry 3

ENV RUBY_YJIT_ENABLE=1

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
