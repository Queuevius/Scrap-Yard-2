class PicPolicy < ApplicationPolicy

  def show?
    true
  end

  def show_pic?
    true
  end

  def update?
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