require "spec_helper"

describe Ability do
  context "for anonymous user" do
    subject(:ability) { Ability.new(nil) }

    it "can't read the secret" do
      ability.should_not be_able_to :read, :secret
    end

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
  end

  context "for authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    subject(:ability) { Ability.new(user) }

    it "can read the secret" do
      ability.should be_able_to :read, :secret
    end

    it "can create a competition" do
      ability.should be_able_to :create, Competition
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
  end
end
