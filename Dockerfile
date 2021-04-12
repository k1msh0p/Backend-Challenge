FROM ruby:2.7.2

LABEL maintainer="Kim Chin"

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends build-essential libpq-dev nodejs

ENV APP_HOME=/myrailsapp

COPY . $APP_HOME

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

WORKDIR $APP_HOME

RUN gem install bundler -v 2.1.2

RUN bundle install

RUN test -f tmp/pids/server.pid && rm -f tmp/pids/server.pid; true

CMD ["rails", "s", "-b", "0.0.0.0"]
