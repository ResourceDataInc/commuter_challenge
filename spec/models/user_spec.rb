require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :memberships }
    it { should have_many :teams }
    it { should have_many :rides }

    it "should delete rides when deleted" do
      user = FactoryGirl.create(:user)
      id = user.id
      user.rides.create(rider_id: user.id, distance: 5, date: Date.today)

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
end
