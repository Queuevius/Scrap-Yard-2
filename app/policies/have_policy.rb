class HavePolicy < ApplicationPolicy

  def show?
    true
  end

  def show_have?
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

  def destroy?
    true
  end

end