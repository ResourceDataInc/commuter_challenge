require 'spec_helper'

describe Bracket do
  context "associations" do
    it { should belong_to :competition }
  end

  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :lower_limit }
    it { should validate_presence_of :upper_limit }
    it { should validate_presence_of :competition}

    it "should require upper limit be greater than lower limit" do
      bracket = FactoryGirl.build :bracket,
        lower_limit: 20,
        upper_limit: 19
      bracket.should_not be_valid
      bracket.should have(1).error_on(:upper_limit)

      bracket.upper_limit = 21
      bracket.should be_valid
    end

    it "should require a lower limit greater or equal to zero" do
      bracket = FactoryGirl.build :bracket,
        lower_limit: -1
      bracket.should_not be_valid
      bracket.should have(1).error_on(:lower_limit)

      bracket.lower_limit = 0
      bracket.should be_valid

      bracket.lower_limit = 1
      bracket.should be_valid
    end

    it "should require range is valid" do
      competition = FactoryGirl.create :competition

      bracket = FactoryGirl.create :bracket,
        competition: competition,
        lower_limit: 1,
        upper_limit: 100
      bracket2 = FactoryGirl.build :bracket,
        competition: competition,
        lower_limit: 0,
        upper_limit: 100

      bracket2.should_not be_valid
      bracket2.should have(1).error_on(:upper_limit)

      bracket2.lower_limit = 5
      bracket2.upper_limit = 150
      bracket2.should have(1).error_on(:lower_limit)

      bracket2.lower_limit = 101
      bracket2.should be_valid
    end
  end

  context "participation" do
    it "should show top 3" do
      Date.stub(today: Date.new(2013, 1, 2))
      competition = FactoryGirl.create(:competition,
        start_on: Date.new(2013, 2, 1),
        end_on: Date.new(2013, 2, 15))
      Date.stub(today: Date.new(2013, 2, 4))
      bracket = FactoryGirl.create :bracket,
        competition: competition,
        lower_limit: 1,
        upper_limit: 100

      # Team1 data
      captain1 = FactoryGirl.create(:user)
      team1mate = FactoryGirl.create(:user)
      team1 = FactoryGirl.create(:team,
        captain: captain1,
        business_size: 10)
      competition.competitors.create(team: team1)
      team1.memberships.create(user: captain1, approved: true)
      team1.memberships.create(user: team1mate, approved: true)
      team1mate.rides.create!(date: Date.today, is_round_trip: true, work_trip: true, bike_distance: 1)
      team1mate.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: true, work_trip: true, bike_distance: 1)
      captain1.rides.create!(date: Date.today, is_round_trip: true, work_trip: true, bike_distance: 2)

      # Team2 data
      captain2 = FactoryGirl.create(:user)
      team2mate = FactoryGirl.create(:user)
      team2 = FactoryGirl.create(:team,
        captain: captain2,
        business_size: 10)
      competition.competitors.create(team: team2)
      team2.memberships.create(user: captain2, approved: true)
      team2.memberships.create(user: team2mate, approved: true)
      team2mate.rides.create!(date: Date.today, is_round_trip: true, work_trip: true, bike_distance: 2)
      team2mate.rides.create!(date: Date.new(2013, 2, 1), is_round_trip: false, work_trip: true, bike_distance: 2)
      captain2.rides.create!(date: Date.today, is_round_trip: false, work_trip: true, bike_distance: 3)

      # Check top 3 teams
      bracket.teams_by_participation[0].name.should == team1.name
      bracket.teams_by_participation[1].name.should == team2.name

      # Check top 3 riders
      bracket.memberships_by_participation[0].user.username.should == team1mate.username
      bracket.memberships_by_participation[1].user.username.should == team2mate.username
      bracket.memberships_by_participation[2].user.username.should == captain1.username
    end
  end

end
