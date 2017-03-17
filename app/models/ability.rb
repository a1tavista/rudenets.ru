class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    user ||= User.new

    # Define abilities here. More info: https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities
  end
end
