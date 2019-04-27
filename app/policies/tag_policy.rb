class TagPolicy < ApplicationPolicy
  # Used by Pundit's #policy_scope
  class Scope < Scope
    def resolve
      # Only admins can list users.
      user.admin? ? scope.all : scope.none
    end
  end

  
  %w[new? create? show?].each do |method_name|
    define_method(method_name) do
      user.present?
    end
  end


end