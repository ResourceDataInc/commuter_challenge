require 'spec_helper'

describe ScoreKeeper do
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team) }
  let(:competition) { FactoryGirl.create(:competition, start_on: 1.month.ago, end_on: 4.months.from_now) }

  before :each do
    FactoryGirl.create(:competitor, competition: competition, team: team)
    FactoryGirl.create(:membership, user: user, team: team)
  end

  it "handles a new ride" do
    ride = FactoryGirl.build(:ride, rider: user, work_trip: true, is_round_trip: true)

    ScoreKeeper.new(user).update(ride) do
      ride.save!
    end

    expect(user.active_membership.ride_count).to eq(2)
  end

  it "handles an updated ride" do
    ride = FactoryGirl.create(:ride, rider: user, work_trip: true, is_round_trip: true)
    user.active_membership.update_attributes ride_count: 2

    ScoreKeeper.new(user).update(ride) do
      ride.update_attributes is_round_trip: false
    end

    expect(user.active_membership.ride_count).to eq(1)
  end

  it "handles a deleted ride" do
    ride = FactoryGirl.create(:ride, rider: user, work_trip: true, is_round_trip: true)
    user.active_membership.update_attributes ride_count: 2

    ScoreKeeper.new(user).update(ride) do
      ride.destroy
    end

    expect(user.active_membership.ride_count).to eq(0)
  end

  it "handles a ride that moves to another week" do
    ride = FactoryGirl.create(:ride, rider: user, work_trip: true, is_round_trip: true, date: Time.now)
    user.active_membership.update_attributes ride_count: 2

    ScoreKeeper.new(user).update(ride) do
      ride.update_attributes date: 2.weeks.ago
    end

    expect(user.active_membership.ride_count).to eq(2)
  end

  it "returns block's return value" do
    ride = FactoryGirl.build(:ride)
    value = ScoreKeeper.new(user).update(ride) do
      42
    end

    expect(value).to eq(42)
  end

  it "does not update score if block returns falsy value" do
    ride = FactoryGirl.build(:ride, rider: user, work_trip: true, is_round_trip: true)

    ScoreKeeper.new(user).update(ride) do
      ride.save
      false
    end

    expect(user.active_membership.ride_count).to eq(0)
  end

  it "does not count personal rides" do
    ride = FactoryGirl.build(:ride, rider: user, work_trip: false)

    ScoreKeeper.new(user).update(ride) do
      ride.save
    end

    expect(user.active_membership.ride_count).to eq(0)
  end

  it "does not count rides outside of competition dates" do
    ride = FactoryGirl.build(:ride, rider: user, work_trip: true, date: competition.start_on - 1.day)

    ScoreKeeper.new(user).update(ride) do
      ride.save
    end

    expect(user.active_membership.ride_count).to eq(0)
  end
end
