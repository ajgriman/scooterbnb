#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# This single command handles both initial setup and all future migrations.
# The environment variable is only needed for the very first deploy.
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:queue