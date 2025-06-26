#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Manually perform the steps of `db:prepare` but skip `db:seed`.
# This gives us full control and avoids errors from seed files.
echo "--- Manually Preparing Unified Database (without seeding) ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:schema:load
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate