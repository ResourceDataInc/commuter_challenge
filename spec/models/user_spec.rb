require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :memberships }
    it { should have_many :teams }
    it { should have_many :rides }

    it "should delete rides when deleted" do
      user = FactoryGirl.create(:user)
      id = user.id
      user.rides.create(rider_id: user.id, bike_distance: 5, date: Date.today)

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

  describe "#total_distance" do
    it "sums all distance" do
      user = FactoryGirl.create(:user)
      user.rides.create(bike_distance: 3)
      user.rides.create(bus_distance: 7)
      user.rides.create(walk_distance: 0.5)
      user.total_distance.should be_within(0.001).of(3 + 7 + 0.5)
    end
  end
end
