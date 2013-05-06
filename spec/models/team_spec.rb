require 'spec_helper'

describe Team do
  context "associations" do
    it { should belong_to :captain }
    it { should have_many :memberships }
    it { should have_many :members }
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
end
