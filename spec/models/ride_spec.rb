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
end
