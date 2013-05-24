require 'spec_helper'

describe Ride do
  context "associations" do
    it { should belong_to :rider }
  end

  context "validation" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :rider } 
    it { should validate_presence_of :distance}

    it "should require distance is larger than 0" do
      ride = FactoryGirl.build :ride, 
        distance: 0
      ride.should_not be_valid
      ride.should have(1).error_on(:distance)
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
