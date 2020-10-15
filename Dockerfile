FROM ruby:2.6.5

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client-common postgresql-client build-essential nodejs libpq-dev yarn

ENV APP_HOME /massgruas
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:1.17.3
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
RUN yarn install --check-files
VOLUME ["$RAILS_ROOT/public"]

EXPOSE 3000

CMD ["rails","server","-b","0.0.0.0"]
# ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
