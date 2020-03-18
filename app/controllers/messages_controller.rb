class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_entities
  before_action :authorize_messages

  def create
    @message = Message.create user: current_user,
                                       room: @room,
                                       message: params.dig(:message, :message)

    if @message.save!
      Notification.create!(recipient_id: @room.reciever_id, actor_id: current_user.id, room_id: @room.id, action: "message", notifiable: @message)
      redirect_back(fallback_location: rooms_path)
    else
      render rooms_path
    end
  end

  protected

  def load_entities
    @room = Room.find params.dig(:message, :room_id)
  end

  def authorize_messages
    authorize Message
  end

end