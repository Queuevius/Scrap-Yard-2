class WantPolicy < ApplicationPolicy

  def show?
    true
  end

  def update?
    true
  end

  def new?
    true
  end

  def index?
    true
  end

  def create?
    true
  end
end