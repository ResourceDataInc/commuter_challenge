require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :memberships }
    it { should have_many :teams }
    it { should have_many :rides }

    it "should delete rides when deleted" do
      user = FactoryGirl.create(:user)
      id = user.id
      user.rides.create(rider_id: user.id, bike_distance: 5, date: Calendar.today)

      user.destroy
      user = Ride.find_by_rider_id(id)
      user.should be_nil
    end
  end

  describe "validation" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
  end

  describe "#active_membership" do
    it "returns membership for team of an active competition" do
      user = FactoryGirl.create(:user)
      active_team = FactoryGirl.create(:team)
      active_competition = FactoryGirl.create(:competition, start_on: 1.week.ago, end_on: 1.month.from_now)
      FactoryGirl.create(:competitor, competition: active_competition, team: active_team)
      active_membership = FactoryGirl.create(:membership, user: user, team: active_team)

      inactive_team = FactoryGirl.create(:team)
      inactive_competition = FactoryGirl.create(:competition, start_on: 12.months.ago, end_on: 10.months.ago)
      FactoryGirl.create(:competitor, competition: inactive_competition, team: inactive_team)
      FactoryGirl.create(:membership, user: user, team: inactive_team)

      expect(user.active_membership).to eq(active_membership)
    end

    it "returns nil when not on a team" do
      user = FactoryGirl.create(:user)
      expect(user.active_membership).to be_nil
    end

    it "returns nil when no active competition" do
      user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team)
      competition = FactoryGirl.create(:competition, start_on: 2.months.ago, end_on: 1.week.ago)
      competitor = FactoryGirl.create(:competitor, competition: competition, team: team)
      membership = FactoryGirl.create(:membership, user: user, team: team)

      expect(user.active_membership).to be_nil
    end
  end
end
