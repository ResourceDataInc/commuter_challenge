# Bike Commute Challenge

[![Build Status](https://travis-ci.org/ResourceDataInc/commuter_challenge.png?branch=master)](https://travis-ci.org/ResourceDataInc/commuter_challenge)
[![Code Climate](https://codeclimate.com/github/ResourceDataInc/commuter_challenge.png)](https://codeclimate.com/github/ResourceDataInc/commuter_challenge)

* [Staging](http://summer-bike-challenge-staging.herokuapp.com/)
* [Production](http://summer-bike-challenge-prod.herokuapp.com/)

## What is it?

An application for tracking commutes for the [Bicycle Commuters of
Anchorage](http://bicycleanchorage.org/wordpress/) annual commuter challenge.

## Development

### Environment
* Ruby 2.1.x
* Rails 4.0.x

### Basics

* Clone the repository
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

### Continuous Integration

Travis is used for automated builds. Travis is setup up to automatically run
the test suite for each push to the repository, and for each pull requests. A
pull request will not be accepted if any spec is failing.

https://travis-ci.org/ResourceDataInc/commuter_challenge

### Code Quality

Code Climate is used for code quality analysis and test coverage.

https://codeclimate.com/github/ResourceDataInc/commuter_challenge
