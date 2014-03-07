class ParticipationCalculator
  attr_reader :competition

  def initialize(competition)
    @competition = competition
  end

  def team_participations
    team_trips = competition.teams.joins(:memberships).group("memberships.team_id").sum("memberships.ride_count")

    competition.teams.map do |team|
      trips = team_trips[team.id].to_i
      team_participation(team, trips)
    end
  end

  def team_participation(team, trips = nil)
    trips ||= team_trips(team)
    possible_trips = possible_trips(team)
    if possible_trips > 0
      percent = 100.0 * trips / possible_trips(team)
    else
      percent = 0.0
    end
    TeamParticipation.new(team, percent.round(1))
  end

  def team_trips(team)
    team.memberships.approved.sum(:ride_count)
  end

  def member_participations
    competition.brackets.flat_map do |bracket|
      # yikes
      memberships = Membership.approved.includes(:team, :user).merge(bracket.teams).order("memberships.ride_count desc").limit(10)
      memberships.map do |membership|
        membership_participation(membership)
      end
    end
  end

  def membership_participation(membership)
    if member_possible_trips > 0
      percent = 100.0 * membership.ride_count / member_possible_trips
    else
      percent = 0.0
    end
    MemberParticipation.new(membership.user, membership.team, percent.round(1))
  end

  def member_possible_trips
    @member_possible_trips ||= weeks_to_date * max_trips_per_week
  end

  def possible_trips(team)
    member_possible_trips * team.business_size
  end

  private

  def max_trips_per_week
    10
  end

  def weeks_to_date
    @weeks_to_date ||= calculation_start_date.step(calculation_end_date, 7).count
  end

  def calculation_start_date
    @calculation_start_date ||= competition.start_on.beginning_of_week
  end

  def calculation_end_date
    @calculation_end_date ||= if Date.today < competition.end_on
      Date.today.end_of_week
    else
      competition.end_on.end_of_week
    end
  end
end

TeamParticipation = Struct.new(:team, :percent)
MemberParticipation = Struct.new(:member, :team, :percent)
