#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# This single command will now set up the unified database.
# It will run all migrations found in db/migrate, including the
# Solid Queue migration we just moved.
echo "--- Preparing Unified Database ---"
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:prepare