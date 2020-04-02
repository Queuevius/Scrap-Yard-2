class TagPolicy < ApplicationPolicy
  # Used by Pundit's #policy_scope
  class Scope < Scope
    def resolve
      # Only admins can list users.
      user.admin? ? scope.all : scope.none
    end
  end

  
  %w[new? create? solo_pic?].each do |method_name|
    define_method(method_name) do
      user.present?
    end
  end

  def show?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def new_layer?
    true 
  end

  def create_layer?
    true 
  end

end