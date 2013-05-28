require 'spec_helper'

describe Calculations do
  context "for team" do
    it "should calculate parcticipation" do
      Date.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
      Date.stub(today: Date.new(2013, 2, 4))
      captain = FactoryGirl.create(:user)
      user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team,
        captain: captain,
        business_size: 10)
      competition.competitors.create(team: team)
      team.memberships.create(user: captain, approved: true)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.today, is_round_trip: true, bike_distance: 1)
      captain.rides.create!(date: Date.today, is_round_trip: false, bike_distance: 2)

      team.participation_percent.should be_within(0.01).of(7.5)
    end

    it "should use max of two trips per day" do
      Date.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
      Date.stub(today: Date.new(2013, 2, 4))
      captain = FactoryGirl.create(:user)
      user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team,
        captain: captain,
        business_size: 10)
      competition.competitors.create(team: team)
      team.memberships.create(user: captain, approved: true)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.today, is_round_trip: true, bike_distance: 1)
      user.rides.create!(date: Date.today, is_round_trip: false, bike_distance: 20)
      captain.rides.create!(date: Date.today, is_round_trip: false, bike_distance: 2)

      team.participation_percent.should be_within(0.01).of(7.5)
    end
  end

  context "for membership" do
    it "should calculate participation" do
      Date.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
      Date.stub(today: Date.new(2013, 2, 4))
      user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team,
        business_size: 10)
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.today, is_round_trip: true, bike_distance: 1)
      user.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: false, bike_distance: 2)

      team.memberships.first.participation_percent.should be_within(0.01).of(75.0)
    end

    it "should use max of two trips per day" do
      Date.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
      Date.stub(today: Date.new(2013, 2, 4))
      user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team,
        business_size: 10)
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.today, is_round_trip: true, bike_distance: 1)
      user.rides.create!(date: Date.today, is_round_trip: false, bike_distance: 2)
      user.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: false, bike_distance: 2)

      team.memberships.first.participation_percent.should be_within(0.01).of(75.0)
    end

    it "should not include rides logged outside of competition dates" do
      Date.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
      Date.stub(today: Date.new(2013, 2, 4))
      user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team,
        business_size: 10)
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.new(2013, 1, 31), is_round_trip: true, bike_distance: 1)
      user.rides.create!(date: Date.new(2013, 2, 2), is_round_trip: false, bike_distance: 2)

      team.memberships.first.participation_percent.should be_within(0.01).of(0.0)
    end
  end
end