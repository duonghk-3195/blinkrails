# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :update, User, id: user.id

    return unless user.is_admin?
    can :update_admin, User
  end
end