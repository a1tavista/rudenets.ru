class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :preview], Post
    can :read, Entry
    can :read, Link

    return unless user.present?

    can :manage, :all
    # Define abilities here. More info: https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities
  end
end
