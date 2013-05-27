require 'spec_helper'

describe Membership do
  describe "associations" do
    it { should belong_to :team }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :team }
    it { should validate_presence_of :user }
  end

  describe "approval" do
    it "sets approved_at" do
      time = Time.parse("1955-11-05")
      Time.stub(now: time)
      membership = FactoryGirl.create(:membership, approved: false)
      membership.approved = true
      membership.save
      membership.approved_at.should == time
    end
  end

  context "parcticipation" do
    it "should calculate membership parcticipation" do
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
  end
end
