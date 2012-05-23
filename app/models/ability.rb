class Ability
  include CanCan::Ability

  def initialize(cyclist)
    
    # use boilerplate code for now
    if cyclist.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
