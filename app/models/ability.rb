class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :read, Entry
    can :read, Link
    
    return unless user.present?
    user ||= User.new

    # Define abilities here. More info: https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities
  end
end
