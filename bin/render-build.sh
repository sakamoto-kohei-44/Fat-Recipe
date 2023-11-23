set -o errexit

bundle install
yarn install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate