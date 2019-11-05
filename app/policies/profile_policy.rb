class ProfilePolicy < ApplicationPolicy
  # Used by Pundit's #policy_scope
  class Scope < Scope
    def resolve
      # Only admins can list users.
      user.admin? ? scope.all : scope.none
    end
  end

  def profile_haves?
    update?
  end

  def profile_wants?
    true
  end
  
  def show?
    true 
  end


  def update?
    true 
  end

  def update_pic?
    true 
  end

end