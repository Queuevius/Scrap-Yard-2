class FriendshipPolicy < ApplicationPolicy

  def create?
    true
  end

  def new?
    true
  end

  def destroy?
    true
  end
end