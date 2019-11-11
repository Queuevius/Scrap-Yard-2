class ConversationPolicy < ApplicationPolicy

  def create?
    true
  end

  def close?
    true
  end

end