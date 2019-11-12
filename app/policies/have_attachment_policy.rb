class HaveAttachmentPolicy < ApplicationPolicy

  def update?
    true
  end

  def create?
    true
  end
end