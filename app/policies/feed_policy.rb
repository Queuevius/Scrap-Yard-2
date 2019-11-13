class FeedPolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    true
  end

  def create?
    true
  end
end