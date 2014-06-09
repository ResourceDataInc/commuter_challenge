require 'spec_helper'

describe WeeklyScoreCalculator do
  let(:sunday) { Date.parse("2014-02-23") }
  let(:saturday) { Date.parse("2014-03-01") }

  it "knows the week of a reference date" do
    counter = WeeklyScoreCalculator.new(Date.parse("2014-02-27"))
    expected_range = sunday..saturday
    expect(counter.date_range).to eq(expected_range)
  end

  it "counts one way trips as one point" do
    ride = FactoryGirl.build(:ride, type: :one_way)
    counter = WeeklyScoreCalculator.new(ride.date)
    expect(counter.points_for_ride(ride)).to eq(1)
  end

  it "counts round trips as two points" do
    ride = FactoryGirl.build(:ride, type: :round_trip)
    counter = WeeklyScoreCalculator.new(ride.date)
    expect(counter.points_for_ride(ride)).to eq(2)
  end

  it "counts vacations as two points" do
    ride = FactoryGirl.build(:ride, type: :vacation)
    counter = WeeklyScoreCalculator.new(ride.date)
    expect(counter.points_for_ride(ride)).to eq(2)
  end

  it "counts a max of two points per day" do
    rides = [
      FactoryGirl.build(:ride, date: sunday, type: :round_trip),
      FactoryGirl.build(:ride, date: sunday, type: :round_trip),
      FactoryGirl.build(:ride, date: sunday, type: :round_trip),
    ]

    counter = WeeklyScoreCalculator.new(sunday)
    expect(counter.score(rides)).to eq(2)
  end

  it "counts a max of ten points per week" do
    rides = (sunday..saturday).map do |day|
      FactoryGirl.build(:ride, date: day, type: :round_trip)
    end

    counter = WeeklyScoreCalculator.new(sunday)
    expect(counter.score(rides)).to eq(10)
  end

  it "calculates the delta score of two sets of rides" do
    rides_a = [
      FactoryGirl.build(:ride, type: :round_trip, date: sunday)
    ]

    rides_b = [
      rides_a.first,
      FactoryGirl.build(:ride, type: :round_trip, date: saturday)
    ]

    counter = WeeklyScoreCalculator.new(sunday)
    expect(counter.delta(rides_a, rides_b)).to eq(2)
  end
end
