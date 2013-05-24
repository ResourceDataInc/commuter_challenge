require 'spec_helper'

describe Team do
  context "associations" do
    it { should belong_to :captain }
    it { should have_many :memberships }
    it { should have_many :members }

    it "should delete memberships when deleted" do
      team = FactoryGirl.create(:team)
      id = team.id
      team.memberships.create(user: FactoryGirl.create(:user))

      team.destroy
      membership = Membership.find_by_team_id(id)
      membership.should be_nil
    end
  end

  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :captain }
    it { should validate_presence_of :business_size }
    it "should require business size is larger than 0" do
      team = FactoryGirl.build :team, 
        business_size: 0
      team.should_not be_valid
      team.should have(1).error_on(:business_size)

      team.business_size = -1
      team.should have(1).error_on(:business_size)

      team.business_size = 1
      team.should be_valid
    end
  end

  context "helpers" do
    it "should count the number of approved users" do
      team = FactoryGirl.create(:team)
      team.memberships.create(user: FactoryGirl.create(:user), approved: true)
      team.memberships.create(user: FactoryGirl.create(:user), approved: true)
      team.memberships.create(user: FactoryGirl.create(:user), approved: false)
      team.approved_users.count.should equal(2)
    end

    it "should calculate team parcticipation" do
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
      user.rides.create!(date: Date.today, is_round_trip: true, distance: 1)
      captain.rides.create!(date: Date.today, is_round_trip: false, distance: 2)

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
      user.rides.create!(date: Date.today, is_round_trip: true, distance: 1)
      user.rides.create!(date: Date.today, is_round_trip: false, distance: 20)
      captain.rides.create!(date: Date.today, is_round_trip: false, distance: 2)

      team.participation_percent.should be_within(0.01).of(7.5)
    end
  end
end
