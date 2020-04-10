class DebatePolicy < ApplicationPolicy
  # Used by Pundit's #policy_scope
  class Scope < Scope
    def resolve
      # Only admins can list users.
      user.admin? ? scope.all : scope.none
    end
  end

  def index?
    true
  end

  def new?
    true
  end


  def create?
    true
  end

  def show?
    true
  end

end