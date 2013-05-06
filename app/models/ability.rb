class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :read, Competition
    can :read, Team
    can :read, Ride
    can :read, Bracket

    if user.present?
      can :read, :secret

      can :manage, Competition, owner_id: user.id
      can :manage, Team, captain_id: user.id
      can :manage, Ride, rider_id: user.id
      can :manage, Bracket, :competition => { :owner_id => user.id }
      can :manage, Membership, user_id: user.id
      can :manage, Membership do |membership|
        membership.team.captain == user
      end

      can :join, Team do |team|
        !team.members.include? user
      end
    end
  end
end
