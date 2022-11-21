# == base
FROM ruby:2.7.6-alpine AS base

WORKDIR /app
ENV RAILS_ENV production
ENV BUNDLE_DEPLOYMENT true
ENV BUNDLE_WITHOUT development:test

RUN gem install bundler

# == builder
FROM base AS builder

# Add packages
RUN apk update && apk add --no-cache --update \
      build-base \
      tzdata \
      nodejs~=16 \
      yarn \
      shared-mime-info

# == bundle
FROM builder AS bundle

# Install gems
COPY Gemfile Gemfile.lock .
RUN bundle install

# == npm
FROM builder AS npm

# Install npm packages
COPY package.json yarn.lock .
RUN yarn install --production --frozen-lockfile
RUN yarn cache clean

# == assets
FROM builder AS assets

COPY . .

COPY --from=npm /app/node_modules node_modules

# Set a dummy value to avoid errors when building docker image.
# refs: https://github.com/rails/rails/issues/32947
RUN SECRET_KEY_BASE=a5374b3b2510648627597e59ef9f6961 bin/rails assets:precompile \
      && rm -rf tmp/cache/*


# == main
FROM base AS main

# Add packages
RUN apk update && apk add --no-cache --update \
      tzdata \
      shared-mime-info

COPY . .

# Copy files from each stages
COPY --from=assets /app/public/assets public/assets
COPY --from=assets /app/public/packs public/packs

ENV PORT 3000
EXPOSE 3000

CMD bin/rails server
