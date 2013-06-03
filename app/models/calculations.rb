class Calculations

  attr_reader :start_on, :end_on

  def initialize(start_on, end_on)
    @start_on = start_on
    @end_on = end_on
  end

  def total_work_days
    @total_work_days ||= work_days_between(start_on, end_on)
  end

  def work_days
    @work_days ||= work_days_between(start_on, Calendar.today)
  end

  def member_participation_percent(rides)    
    (member_possible_rides == 0)? 0.0 : (100.0 * member_actual_rides(rides) / member_possible_rides).round(1)
  end

  def member_actual_rides(rides)
    # here be dragons
    dated_rides = competition_rides(rides).group_by(&:date)
    dated_rides.inject(0) do |total, (_, rides)|
      total + [2, rides.inject(0) {|total, r| total + (r.is_round_trip ? 2 : 1)}].min
    end
  end

  def team_participation_percent(business_size, rides)
    possible_rides = team_possible_rides(business_size)
    (possible_rides == 0)? 0.0 : (100.0 * team_actual_rides(rides) / possible_rides).round(1)
  end

  def team_actual_rides(rides)
    # here be dragons
    user_rides = competition_rides(rides).group_by(&:rider_id)
    user_rides.inject(0) do |total, (_, rides)|
      dated_rides = rides.group_by(&:date)
      total + dated_rides.inject(0) do |total, (_, rides)|
        total + [2, rides.inject(0) {|total, r| total + (r.is_round_trip ? 2 : 1)}].min
      end
    end
  end

  private
    def member_possible_rides
      2 * work_days
    end

    def team_possible_rides(business_size)
      business_size * member_possible_rides
    end

    def work_days_between(date1, date2)
      (date1 <= date2 && date2 <= end_on) ? (date1..date2).select { |d| (1..5).include?(d.wday) }.size : 0
    end

    def competition_rides(rides)
      from_date = (Calendar.today <= end_on) ? Calendar.today : end_on
      if start_on <= Calendar.today
        dates = start_on..from_date
        week_days = 1..5
        rides.select { |ride|
          dates.include?(ride.date) && ride.work_trip? && week_days.include?(ride.date.wday)
        }
      else
        []
      end
    end
end
