class FriendshipPolicy < ApplicationPolicy

  def destroy?
    true
  end

  def create?
    true
  end
end