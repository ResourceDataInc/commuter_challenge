class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :read, Competition

    if user.present?
      can :read, :secret

      can :manage, Competition, owner_id: user.id
    end
  end
end
