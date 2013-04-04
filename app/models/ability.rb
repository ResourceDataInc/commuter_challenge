class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :read, :secret if user.present?
  end
end
