require 'spec_helper'

describe Ride do
  context "associations" do
    it { should belong_to :rider }
  end

  context "validation" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :rider }

    it "should require distance is larger than 0" do
      ride = FactoryGirl.build :ride,
        bike_distance: 0,
        bus_distance: 0,
        walk_distance: 0
      ride.should_not be_valid
      ride.should have(1).error_on(:bike_distance)
      ride.should have(1).error_on(:bus_distance)
      ride.should have(1).error_on(:walk_distance)
    end

    it "allows for zero values if total value is > 0" do
      ride = FactoryGirl.build :ride,
        bike_distance: 0,
        bus_distance: 4,
        walk_distance: 0
      ride.should be_valid
    end

    it "requires at least one distance" do
      ride = FactoryGirl.build(:ride, bike_distance: nil, bus_distance: nil, walk_distance: nil)
      ride.should_not be_valid
      ride.bus_distance = 11
      ride.should be_valid
    end

    it "cannot be logged for a future date" do
      ride = FactoryGirl.build :ride, date: Date.tomorrow
      ride.should_not be_valid
      ride.should have(1).error_on(:date)
      ride.date = Date.today
      ride.should be_valid
    end
  end

  describe "#total_distance" do
    it "sums all distance fields" do
      ride = FactoryGirl.build(:ride, bike_distance: 2.5, bus_distance: 7)
      ride.total_distance.should be_within(0.001).of(9.5)
    end

    it "returns zero when no distance values" do
      ride = FactoryGirl.build(:ride, bike_distance: nil, bus_distance: nil, walk_distance: nil)
      ride.total_distance.should == 0
    end
  end
end
