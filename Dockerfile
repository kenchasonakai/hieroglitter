FROM ruby:2.7.6

ENV RAILS_ENV production
ENV BUNDLE_DEPLOYMENT true
ENV BUNDLE_WITHOUT development:test

WORKDIR /hieroglitter

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn

RUN gem install bundler

COPY Gemfile /hieroglitter/Gemfile
COPY Gemfile.lock /hieroglitter/Gemfile.lock

RUN bundle install

COPY package.json yarn.lock .
RUN yarn install --production --frozen-lockfile
RUN yarn cache clean

COPY . /hieroglitter

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
