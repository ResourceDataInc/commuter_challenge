require 'spec_helper'

describe Ride do
  context "associations" do
    it { should belong_to :rider }
  end

  describe "validation" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :rider }

    context "for one way or round trip" do
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
    end

    context "for vacations" do
      it "distance is ignored when created" do
        ride = FactoryGirl.build(:ride, walk_distance: 10, type: :vacation)
        expect(ride).to be_valid
        expect(ride.walk_distance).to eq(nil)
        expect(ride.total_distance).to eq(0)
      end

      it "distance is set to zero when type changes to vacation" do
        ride = FactoryGirl.create(:ride, type: :round_trip, bike_distance: 1)
        ride.update_attributes(type: :vacation)
        expect(ride.bike_distance).to eq(nil)
        expect(ride.total_distance).to eq(0)
      end
    end

    it "must be logged within two weeks of current date" do
      ride = FactoryGirl.build(:ride, date: Calendar.today - 15.days)
      ride.should_not be_valid
      ride.should have(1).error_on(:date)
      ride.date = Calendar.today - 14.days
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

  describe "work_trips" do
    it "only returns work trips" do
      work = FactoryGirl.create(:ride, work_trip: true)
      personal = FactoryGirl.create(:ride, work_trip: false)
      trips = Ride.work_trips
      trips.should include work
      trips.should_not include personal
    end
  end

  describe "total_distance" do
    it "sums up all distances" do
      FactoryGirl.create(:ride, bike_distance: 5, bus_distance: nil, walk_distance: nil)
      FactoryGirl.create(:ride, bike_distance: nil, bus_distance: 2, walk_distance: 0.5)

      expect(Ride.total_distance).to be_within(0.001).of(7.5)
    end
  end
end
