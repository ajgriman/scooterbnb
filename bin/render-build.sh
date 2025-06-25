set -o errexit

bundle install --without development test
bundle exec rake assets:precompile
bundle exec rake assets:clean

# For the very first deploy, load your schema so 'vehicles' exists
bundle exec rake db:schema:load

# For subsequent deploys, you can switch to just running
bundle exec rake db:migrate