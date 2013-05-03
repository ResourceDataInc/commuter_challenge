class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :read, Competition
    can :read, Team
    can :read, Ride

    if user.present?
      can :read, :secret

      can :manage, Competition, owner_id: user.id
      can :manage, Team, captain_id: user.id
      can :manage, Ride, rider_id: user.id
    end
  end
end
