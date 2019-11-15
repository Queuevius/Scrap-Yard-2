class ConversationsController < ApplicationController
  after_action :authorize_conversations, only: [:create, :close]

  def create

  end

  private

  def authorize_conversations
    authorize Conversation
  end
end