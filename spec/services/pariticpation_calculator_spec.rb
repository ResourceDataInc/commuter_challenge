require 'spec_helper'

describe ParticipationCalculator do
  let(:team) { FactoryGirl.create(:team) }
  let(:competition) { FactoryGirl.create(:competition) }

  before :each do
    FactoryGirl.create(:competitor, competition: competition, team: team)
  end

  subject(:counter) { ParticipationCalculator.new(competition) }

  describe "team trips" do
    it "sums up members trip count" do
      FactoryGirl.create(:membership, team: team, ride_count: 5)
      FactoryGirl.create(:membership, team: team, ride_count: 7)

      expect(counter.team_trips(team)).to eq(12)
    end

    it "does not include unapproved memberships" do
      FactoryGirl.create(:membership, team: team, ride_count: 5)
      FactoryGirl.create(:membership, team: team, ride_count: 7, approved: false)

      expect(counter.team_trips(team)).to eq(5)
    end
  end

  describe "possible trips" do
    it "are limited to 10 per week per employee" do
      team.update_attributes business_size: 4
      competition.update_attributes(start_on: Date.today.beginning_of_week,
                                    end_on: Date.today.end_of_week)

      # 1 week, 4 people, 10 trips per person per week
      expect(counter.possible_trips(team)).to eq(40)
    end

    it "are calculated weekly even if start/end are mid-week" do
      team.update_attributes business_size: 50
      # Tuesday through Monday
      competition.update_attributes(start_on: Date.today.beginning_of_week + 2,
                                    end_on: Date.today.end_of_week + 2)

      Date.stub(today: competition.end_on)

      # 2 weeks, 50 people, 10 trips per person per week
      expect(counter.possible_trips(team)).to eq(1000)
    end
  end

  describe "team participation" do
    it "is percent of rides logged per total possible given business size" do
      team.update_attributes business_size: 4
      competition.update_attributes(start_on: Date.today.beginning_of_week,
                                    end_on: Date.today.end_of_week)

      FactoryGirl.create(:membership, team: team, ride_count: 5)
      FactoryGirl.create(:membership, team: team, ride_count: 7)

      expect(counter.team_participation(team).percent).to be_within(0.001).of(30)
    end

    it "does not include unapproved members" do
      team.update_attributes business_size: 2
      competition.update_attributes(start_on: Date.today.beginning_of_week,
                                    end_on: Date.today.end_of_week)

      FactoryGirl.create(:membership, team: team, ride_count: 5)
      FactoryGirl.create(:membership, team: team, ride_count: 7, approved: false)

      expect(counter.team_participation(team).percent).to be_within(0.001).of(25)
    end

    it "is is zero if competition has not started yet" do
      team.update_attributes business_size: 4
      competition.update_attributes(start_on: 1.month.from_now, end_on: 4.months.from_now)

      FactoryGirl.create(:membership, team: team, ride_count: 5)
      FactoryGirl.create(:membership, team: team, ride_count: 7)

      expect(counter.team_participation(team).percent).to be_within(0.001).of(0)
    end
  end

  describe "member participation" do
    it "is percent of rides logged per total possible" do
      competition.update_attributes(start_on: Date.today.beginning_of_week,
                                    end_on: Date.today.end_of_week)

      membership = FactoryGirl.create(:membership, team: team, ride_count: 5)

      expect(counter.membership_participation(membership).percent).to be_within(0.001).of(50)
    end

    it "is is zero if competition has not started yet" do
      competition.update_attributes(start_on: 1.month.from_now, end_on: 4.months.from_now)
      membership = FactoryGirl.create(:membership, team: team, ride_count: 5)

      expect(counter.membership_participation(membership).percent).to be_within(0.001).of(0)
    end
  end
end
