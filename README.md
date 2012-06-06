# Summer Beat Down Extreme Biking Challenge

## What is it?

An app for the [Anchorage Summer Bike Commute Challenge](http://bicycleanchorage.org/).

## Test 
[Test Site](http://bca-summer-bike-challenge.heroku.com)
## Development 

### Environment
* Ruby 1.9.3 p194
* Rails 3.2.3

### Basics
* Checkout code: `git clone git@github.com:ResourceDataInc/summer_beat_down_extreme_biking_challenge`
* Install prerequisites: `bundle install`

### Heroku
See [this](https://devcenter.heroku.com/articles/rails3) article for more information on Heroku and Rails.
* Add the heroku remote: `git remote add heroku git@bca-summer-bike-challenge.git`
* Add heroku login credentials: `heroku keys:add`

### Dev Process
Use small feature branches for development. When a feature is complete and ready to be merged, initiate a Pull Request on GitHub to merge your `feature_branch` *into* the `master` branch. Other team members will then review your changes. Once everyone agrees the feature is good to go, go ahead and merge your branch in.

### Secrets
I started to set this up from scratch and got bored so used [this](http://railsapps.github.com/tutorial-rails-bootstrap-devise-cancan.html) as a base.