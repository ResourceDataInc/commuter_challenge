#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

BikeCommuteChallenge::Application.load_tasks

if ENV["RAILS_ENV"].nil? || ENV["RAILS_ENV"] == "development" || ENV["RAILS_ENV"] == "test"
  require "ci/reporter/rake/rspec"
  RSpec::Core::RakeTask.new ci: "ci:setup:rspec"
end
