# Authorization policy for Admin::UsersController. *Not* used by Devise's
# controllers.
class PostPolicy < ApplicationPolicy

  attr_reader :user, :post

  # Used by Pundit's #policy_scope
  class Scope < Scope
    def resolve
      # Only admins can list users.
      user.admin? ? scope.all : scope.none
    end
  end

  
  %w[new? create? index?].each do |method_name|
    define_method(method_name) do
      user.present?
    end
  end

  def homepage?
    true
  end

  def new_design?
    true 
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

  def create_token?
    true
  end

  def all_tokens?
    true
  end

  def show_token?
    true
  end

  def add_rating?
    true
  end

end