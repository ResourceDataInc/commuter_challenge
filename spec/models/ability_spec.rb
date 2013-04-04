require "spec_helper"

describe Ability do
  context "for anonymous user" do
    it "can't read the secret" do
      ability = Ability.new(nil)
      ability.should_not be_able_to :read, :secret
    end
  end

  context "for authenticated user" do
    it "can read the secret" do
      ability = Ability.new(FactoryGirl.create(:user))
      ability.should be_able_to :read, :secret
    end
  end
end
