class MessagesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :load_entities
  before_action :authorize_messages

  def create
    @message = Message.create user: current_user,
                                       room: @room,
                                       message: params.dig(:message, :message)

    RoomChannel.broadcast_to @room, @message
  end

  protected

  def load_entities
    @room = Room.find params.dig(:message, :room_id)
  end

  def authorize_messages
    authorize Message
  end

end