require 'spec_helper'

describe Calculations do

  let!(:competition) { 
      Calendar.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
  }
  let(:user) {FactoryGirl.create(:user)}
  let(:team) {team = FactoryGirl.create(:team, business_size: 10)}

  before :each do
    Calendar.stub(today: Date.new(2013, 2, 4))
  end

  context "for team" do
    let(:captain) {FactoryGirl.create(:user)}

    before :each do
      team.captain = captain
      competition.competitors.create(team: team)
      team.memberships.create(user: captain, approved: true)
      team.memberships.create(user: user, approved: true)
    end

    it "should calculate parcticipation" do
      user.rides.create!(date: Calendar.today, is_round_trip: true, work_trip: true, bike_distance: 1)
      captain.rides.create!(date: Calendar.today, is_round_trip: false, work_trip: true, bike_distance: 2)

      team.participation_percent.should be_within(0.01).of(7.5)
    end

    it "should use max of two trips per day" do
      user.rides.create!(date: Calendar.today, is_round_trip: true, work_trip: true, bike_distance: 1)
      user.rides.create!(date: Calendar.today, is_round_trip: false, work_trip: true, bike_distance: 20)
      captain.rides.create!(date: Calendar.today, is_round_trip: false, work_trip: true, bike_distance: 2)

      team.participation_percent.should be_within(0.01).of(7.5)
    end
  end

  context "for membership" do
    it "should calculate participation" do      
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Calendar.today, is_round_trip: true, work_trip: true, bike_distance: 1)
      user.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: false, work_trip: true, bike_distance: 2)

      team.memberships.first.participation_percent.should be_within(0.01).of(75.0)
    end

    it "should use max of two trips per day" do
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Calendar.today, is_round_trip: true, work_trip: true, bike_distance: 1)
      user.rides.create!(date: Calendar.today, is_round_trip: false, work_trip: true, bike_distance: 2)
      user.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: false, work_trip: true, bike_distance: 2)

      team.memberships.first.participation_percent.should be_within(0.01).of(75.0)
    end

    it "should not include rides logged outside of competition dates" do
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.new(2013, 1, 31), is_round_trip: true, bike_distance: 1, work_trip: true)
      user.rides.create!(date: Date.new(2013, 2, 2), is_round_trip: false, bike_distance: 2, work_trip: true)

      team.memberships.first.participation_percent.should be_within(0.01).of(0.0)
    end

    it "should not include personal rides" do
      competition.competitors.create(team: team)
      team.memberships.create(user: user, approved: true)
      user.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: true, work_trip: false, bike_distance: 1)
      user.rides.create!(date: Date.new(2013, 2, 4), is_round_trip: false, work_trip: false, bike_distance: 2)

      team.memberships.first.participation_percent.should be_within(0.01).of(0.0)
    end
  end
end
