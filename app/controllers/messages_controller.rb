class MessagesController < ApplicationController
  before_action :authorize_messages, only: [:create]

  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def authorize_messages
    authorize Message
  end

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end