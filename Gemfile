source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem 'redis'

gem 'redis-rails', '~> 5.0', '>= 5.0.1'

gem 'hiredis'

gem 'acts_as_list', '~> 1.1'

gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'

gem 'omniauth', '1.9.1'

gem 'omniauth-google-oauth2'

gem 'config', '~> 4.2', '>= 4.2.1'

gem 'annotate', '~> 3.2'

gem 'binding_of_caller', '~> 1.0'

gem 'bullet', '~> 7.0', '>= 7.0.7'

gem 'hotwire-rails'

gem 'sassc-rails'

gem 'httparty', '~> 0.21.0'

gem 'carrierwave'

gem 'rails-i18n'

gem 'letter_opener_web'

gem 'enum_help'

gem 'ransack'

gem 'chartkick'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.7", ">= 7.0.7.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem 'bootstrap', '~> 5.0.0'
gem "sorcery"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-capybara'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rspec-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "factory_bot_rails"
  gem 'rspec-rails'
  gem "selenium-webdriver"
  gem 'shoulda-matchers'
  gem 'webmock'
end
