# Bike Commute Challenge
* [Staging](http://summer-bike-challenge-staging.herokuapp.com/)
* [Production](http://summer-bike-challenge-prod.herokuapp.com/)

## What is it?

An application for setting up and tracking bicycle competitions.

## Development

### Environment
* Ruby 2.0.0
* Rails 3.2.x

### Basics
* Checkout code: `git@github.com:ResourceDataInc/bike_commute_challenge.git`
* Install bundler: `gem install bundler`
* Install prerequisites: `bundle install`

### Database Setup

1. Install PostgreSQL.
1. Create a database user using the following command.

        createuser -d -S -R -P -h localhost bike_commute_challenge

1. Enter "peddlehard" as the password.
1. From the Rails application root directory, run the following command.

        rake db:create:all

1. From the Rails application root directory, run the following command.

        rake db:migrate

### Dev Process

* Use small feature branches for development.
* When a feature is complete and ready to be merged, initiate a Pull Request on
  GitHub to merge your `feature_branch` *into* the `master` branch. Other team
  members will then review your changes.
* Once everyone agrees the feature is good to go, merge your branch.

### Jenkins

TODO: Set up Travis CI
