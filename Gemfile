source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '3.2.13'
gem 'pg', '~> 0.15'
gem 'jquery-rails', '~> 2.2'
gem 'devise', '~> 2.2'
gem 'simple_form', '~> 2.1'
gem 'cancan', '~> 1.6'
gem 'bootstrap-datepicker-rails', '~> 1.0'
gem 'newrelic_rpm'
gem 'jquery-cookie-rails'
gem 'google-analytics-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :production, :staging do
  gem 'unicorn'
end

group :development, :test do
  gem 'shoulda-matchers', '~> 1.5'
  gem 'rspec-rails', '~> 2.13'
  gem 'capybara', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'ci_reporter', '~> 1.8'
  gem 'launchy'
end

group :development do
  gem 'better_errors', '~> 0.7'
  gem 'letter_opener'
end
