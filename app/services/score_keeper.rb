class ScoreKeeper
  attr_reader :rider

  def initialize(rider)
    @rider = rider
  end

  def update(ride, &block)
    return_value = nil

    rider.transaction do
      score_counter = WeeklyScoreCalculator.new(ride.date)
      trips_before = work_trips(score_counter.date_range)

      return_value = block.call

      if return_value && valid_ride?(ride)
        trips_after = work_trips(score_counter.date_range)
        delta = score_counter.delta(trips_before, trips_after)

        # if ride moves to another week, that week's score needs updating too
        unless score_counter.date_range.cover? ride.date
          score_counter = WeeklyScoreCalculator.new(ride.date)
          trips_before = work_trips(score_counter.date_range)
          trips_after = trips_before - [ride]

          delta += score_counter.delta(trips_before, trips_after)
        end

        active_membership.ride_count += delta
        active_membership.save
      end
    end

    return_value
  end

  private

  def valid_ride?(ride)
    active_membership && active_membership.competition.date_range.cover?(ride.date)
  end

  def active_membership
    @active_membership ||= rider.active_membership
  end

  def work_trips(range)
    rider.rides.work_trips.where(date: range).to_a
  end
end
