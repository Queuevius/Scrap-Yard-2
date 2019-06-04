class ItemPolicy < ApplicationPolicy
  # Used by Pundit's #policy_scope
  class Scope < Scope
    def resolve
      # Only admins can list users.
      user.admin? ? scope.all : scope.none
    end
  end

  
  def show?
    true 
  end


  def update?
    true 
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

end