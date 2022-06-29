# frozen_string_literal: true

# this class adds cancancan abilities for users based on their roles
class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    can :read, Vendor
    can :read, Database

    return if user.editor

    can %i[update create], Vendor
    can %i[update create], Database

    return unless user.admin

    can %i[update create destroy], Vendor
    can %i[update create destroy], Database
  end
end
