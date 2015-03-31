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

    it "should require business size equal or greater than memberships " do
      team = FactoryGirl.build :team
      5.times do
        FactoryGirl.create(:membership, team: team, approved: true)
      end       
      team.should be_valid
      team.business_size = 4
      team.should_not be_valid
      team.should have(1).error_on(:business_size)   
    end
  end
end
