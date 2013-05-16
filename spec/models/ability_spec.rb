require "spec_helper"

describe Ability do
  context "for anonymous user" do
    subject(:ability) { Ability.new(nil) }

    it "can read all competitions" do
      ability.should be_able_to :read, Competition
    end

    it "cannot create a competition" do
      ability.should_not be_able_to :create, Competition
    end

    it "can read all teams" do
      ability.should be_able_to :read, Team
    end

    it "cannot create a team" do
      ability.should_not be_able_to :create, Team
    end

    it "cannot create a bracket" do
      ability.should_not be_able_to :create, Bracket
    end

    it "cannot join a team" do
      ability.should_not be_able_to :join, Team.new
    end

    it "cannot create a membership" do
      ability.should_not be_able_to :create, Membership
    end

    it "cannot create a competitor" do
      ability.should_not be_able_to :create, Competitor
    end

    it "should be able to read user" do
      ability.should be_able_to :read, User
    end
  end

  context "for authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    subject(:ability) { Ability.new(user) }

    it "cannot create a competition" do
      ability.should_not be_able_to :create, Competition
    end

    it "can manage own competition" do
      competition = FactoryGirl.create :competition, owner: user
      ability.should be_able_to :manage, competition
    end

    it "cannot manage another user's competition" do
      competition = FactoryGirl.create :competition
      ability.should_not be_able_to :manage, competition
    end

    it "can create a team" do
      ability.should be_able_to :create, Team
    end

    it "can manage own team" do
      team = FactoryGirl.create :team, captain: user
      ability.should be_able_to :manage, team
    end

    it "cannot manage another user's team" do
      team = FactoryGirl.create :team, captain: FactoryGirl.create(:user)
      ability.should_not be_able_to :manage, team
    end

    it "can create a bracket" do
      ability.should be_able_to :create, Bracket
    end

    it "can manage own bracket" do
      bracket = FactoryGirl.create :bracket, 
        competition: FactoryGirl.create(:competition, owner: user)
      ability.should be_able_to :manage, bracket
    end

    it "cannot manage another user's competition bracket" do
      bracket = FactoryGirl.create :bracket
      ability.should_not be_able_to :manage, bracket
    end

    it "can join a team" do
      team = FactoryGirl.create(:team)
      ability.should be_able_to :join, team
    end

    it "cannot rejoin a team" do
      team = FactoryGirl.create(:team)
      FactoryGirl.create(:membership, team: team, user: user)
      ability.should_not be_able_to :join, team
    end

    it "can create membership" do
      ability.should be_able_to :create, Membership
    end

    it "cannot manage a competitor" do
      team = FactoryGirl.create(:team, captain: FactoryGirl.create(:user))
      competitor = FactoryGirl.create(:competitor, team: team)
      ability.should_not be_able_to :manage, competitor
    end
  end

  context "team captain" do
    let(:user) { FactoryGirl.create(:user) }
    subject(:ability) { Ability.new(user) }
    let(:team) { FactoryGirl.create(:team, captain: user) }

    it "can manage memberships" do
      membership = FactoryGirl.create(:membership, team: team)
      ability.should be_able_to :manage, membership
    end

    it "cannot rejoin a team" do
      FactoryGirl.create :membership, team: team, user: user
      ability.should_not be_able_to :join, team
    end

    it "can manage competitors" do
      team = FactoryGirl.create(:team, captain: user)
      competitor = FactoryGirl.create(:competitor, team: team)
      ability.should be_able_to :manage, competitor
    end
  end
end
