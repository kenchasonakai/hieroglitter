#!/bin/sh
set -e

RAILS_ENV=production bin/webpack
RAILS_ENV=production bin/rails assets:precompile
RAILS_ENV=production bin/rails db:migrate

rm -f tmp/pids/server.pid && bin/rails s -e production