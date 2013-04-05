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
  end
end
