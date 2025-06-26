#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

echo "--- Waiting 15 seconds for database to be ready... ---"
sleep 15

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:queue