# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, Vendor

    return unless user.present?

    can [:update, :create, :destroy], Vendor
  end
end
