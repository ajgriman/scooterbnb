#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# --- Workaround for Rails 8.0.x bug #52829 ---
# We must prepare each database independently to avoid the primary
# db:migrate command from erroneously overwriting the queue schema.
# The DISABLE_DATABASE_ENVIRONMENT_CHECK is still needed for the first deploy.

echo "--- Preparing Primary Database ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:prepare

echo "--- Preparing Queue Database ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:prepare:queue