class NotificationPolicy < ApplicationPolicy

  def index?
    true
  end

  def mark_as_read?
    true
  end

  def update?
    true
  end

  def edit?
    true
  end
end