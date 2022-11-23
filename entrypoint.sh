#!/bin/sh
set -e

# 自分のアプリに合わせて必要なコマンドを修正してください
RAILS_ENV=production bin/rails db:migrate
RAILS_ENV=production bin/rails db:seed

rm -f tmp/pids/server.pid && bin/rails s -e production
