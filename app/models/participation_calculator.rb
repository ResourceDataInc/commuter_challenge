class ParticipationCalculator
  attr_reader :competition

  def initialize(competition)
    @competition = competition
  end

  def start_on
    competition.start_on
  end

  def end_on
    competition.end_on
  end

  def total_work_days
    @total_work_days ||= work_days_between(start_on, end_on)
  end

  def work_days
    @work_days ||= work_days_between(start_on, Date.today)
  end

  def member_participations
    # wat
    competition.teams.flat_map { |team|
      team.members.map { |member| member_participation(member, team) }
    }
  end

  def member_participation(member, team)
    participation = (member_possible_rides == 0)? 0.0 : (100.0 * member_actual_rides(member.rides) / member_possible_rides).round(1)
    MemberParticipation.new(member, team, participation)
  end

  def member_actual_rides(rides)
    # here be dragons
    dated_rides = competition_rides(rides).group_by(&:date)
    dated_rides.inject(0) do |total, (_, rides)|
      total + [2, rides.inject(0) {|total, r| total + (r.is_round_trip ? 2 : 1)}].min
    end
  end

  def team_participations
    competition.teams.map { |team| team_participation(team) }
  end

  def team_participation(team)
    possible_rides = team_possible_rides(team.business_size)
    participation = (possible_rides == 0)? 0.0 : (100.0 * team_actual_rides(team.rides) / possible_rides).round(1)
    TeamParticipation.new(team, participation)
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
      from_date = (Date.today <= end_on) ? Date.today : end_on
      if start_on <= Date.today
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

TeamParticipation = Struct.new(:team, :participation_percent)
MemberParticipation = Struct.new(:member, :team, :participation_percent)
