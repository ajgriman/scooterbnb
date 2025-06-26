#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# --- Workaround for Rails 8 bug #52829 and multi-db setup ---
# First, prepare the primary database.
# 'db:prepare' will load the schema or run migrations as needed.
echo "--- Preparing Primary Database ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:prepare

# Second, for the queue database on a fresh deploy, we must first
# create it, then load its specific schema.
echo "--- Creating and Loading Queue Database ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:create:queue
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:schema:load:queue

# For subsequent deploys, this command will handle new queue migrations.
# It is safe to run here as it will do nothing if there are no new migrations.
echo "--- Migrating Queue Database (if needed) ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:queue