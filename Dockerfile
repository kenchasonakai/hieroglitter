FROM ruby:2.7.2
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /hieroglitter
WORKDIR /hieroglitter
RUN gem install bundler:2.2.11
COPY Gemfile /hieroglitter/Gemfile
COPY Gemfile.lock /hieroglitter/Gemfile.lock
COPY yarn.lock /hieroglitter/yarn.lock
RUN bundle install
RUN yarn install
COPY . /hieroglitter
