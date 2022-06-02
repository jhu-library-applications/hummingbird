# frozen_string_literal: true

# this class adds cancancan abilities for users based on their roles
class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Vendor

    return if user.blank?

    can %i[update create destroy], Vendor
  end
end
