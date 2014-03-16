source 'https://rubygems.org'

ruby '2.1.1'

# loaded before everything else
gem 'dotenv-rails', groups: [:development, :test]

gem 'rake', '~> 10.0'
gem 'rails', '4.0.4'
gem 'pg', '~> 0.15'
gem 'jquery-rails'
gem 'devise', '~> 3.2'
gem 'simple_form', '~> 3.0'
gem 'cancan', '~> 1.6'
gem 'newrelic_rpm'
gem 'jquery-cookie-rails'
gem 'google-analytics-rails'

# gem 'turbolinks'
gem 'sass-rails',   '~> 4.0.0'
gem 'bootstrap-sass', '~> 2.3'
gem 'bootstrap-datepicker-rails', '~> 1.0'
gem 'font-awesome-sass-rails', "~> 3.0"
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier', '>= 1.3.0'

group :production, :staging do
  gem 'unicorn', :platforms => :ruby
  gem 'rails_12factor'
  gem 'heroku_rails_deflate'
end

group :development, :test do
  gem 'shoulda-matchers', '~> 2.5'
  gem 'rspec-rails', '~> 2.13'
  gem 'capybara', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'ci_reporter', '~> 1.8'
  gem 'launchy'
end

group :development do
  gem 'better_errors', '~> 1.0'
  gem 'letter_opener'
  gem 'binding_of_caller'
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
