class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Publication
    can [:read, :preview], Publication::Post
    can :read, Publication::Link

    return unless user.present?

    can :manage, :all
  end
end
