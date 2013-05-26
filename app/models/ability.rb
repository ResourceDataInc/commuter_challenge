class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :read, Competition
    can :read, Team
    can :read, Ride
    can :read, Bracket
    can :read, User

    if user.present?
      can :index, :dashboard
      can :manage, Competition, owner_id: user.id
      cannot :create, Competition 
      can :manage, Team, captain_id: user.id
      can :manage, Ride, rider_id: user.id
      can :manage, Bracket, :competition => { :owner_id => user.id }
      can :manage, Membership, user_id: user.id
      can :manage, Membership do |membership|
        membership.team.captain == user
      end
      can :manage, Competitor do |competitor|
        competitor.team.captain == user || competitor.competition.owner == user
      end

      can :join, Team do |team|
        !team.members.include? user
      end

      cannot :join, Team do |team|
        team.members.include? user
      end
    end
  end
end
