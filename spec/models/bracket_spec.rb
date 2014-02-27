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
end
