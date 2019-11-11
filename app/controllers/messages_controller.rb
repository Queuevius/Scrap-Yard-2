class MessagesController < ApplicationController
  after_action :authorize_message, only: [:create]

  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end

  def authorize_message
    authorize Message
  end
end