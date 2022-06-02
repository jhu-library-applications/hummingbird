# frozen_string_literal: true

# this class adds cancancan abilities for users based on their roles
class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.blank?
    can :read, Vendor

    return if user.editor
    can %i[update create], Vendor

    return if !user.admin
    can %i[update create destroy], Vendor
  end
end
