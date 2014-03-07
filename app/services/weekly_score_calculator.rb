class WeeklyScoreCalculator
  attr_reader :reference_date

  def initialize(reference_date)
    @reference_date = reference_date
  end

  def date_range
    reference_date.beginning_of_week..reference_date.end_of_week
  end

  def score(trips)
    by_day = trips.group_by { |r| r.date.wday }

    daily_totals = by_day.map do |_, trips|
      daily_total = trips.inject(0) { |t, r| t + points_for_ride(r) }
      daily_total > max_per_day ? max_per_day : daily_total
    end

    weekly_total = daily_totals.sum
    weekly_total > max_per_week ? max_per_week : weekly_total
  end

  def delta(trips_a, trips_b)
    score(trips_b) - score(trips_a)
  end

  def points_for_ride(ride)
    ride.is_round_trip ? 2 : 1
  end

  def max_per_week
    10
  end

  def max_per_day
    2
  end
end
