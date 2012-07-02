class Ability
  include CanCan::Ability

  def initialize(user)
    # TODO: Use rolify for scoped roles (ie Team captain)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all    
    elsif user.has_role? :cyclist
      can :manage, Ride, :user_id => user.id
      can :manage, Competition, :user_id => user.id
      can :manage, Team, :user_id => user.id
      can :manage, TeamsUser do |teams_user| 
        teams_user.team.user_id == user.id
      end
      can :join, Team do |team|
        user.not_a_member? team
      end
      can :leave, Team do |team|
        user.member? team
      end 
    end
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
