class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_rooms, only: [:create, :new, :index, :edit, :update, :show]
  before_action :load_entities

  def index
    policy_scope(Room) if current_user

    @users = User.all.where.not(id: current_user)

    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new room: @room
    @messages = @room.messages.includes(:user)

    @room.messages.each do |p|
     Notification.where(notifiable_id: p.id).where(recipient_id: current_user.id).where(read_at: nil).each do |t|
      t.update!(read_at: Time.now)
     end
    end

  end

  def new
    @room = Room.new
  end

  def create
    room = Room.where('(sender_id = :sender_id AND reciever_id = :reciever_id) OR
      (sender_id = :reciever_id AND reciever_id = :sender_id)',
               room: permitted_parameters[:room],
               sender_id: permitted_parameters[:sender_id],
               reciever_id: permitted_parameters[:reciever_id]).first_or_create!(permitted_parameters)

    redirect_to room_path(room.id)


  end


  def edit
    @room.find(params[:id])
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  private

  def load_entities
    @room = Room.new
    @rooms = Room.all
    @room = Room.includes(:user).find(params[:id]) if params[:id]

  end

  def permitted_parameters
    params.require(:room).permit(:name, :sender_id, :reciever_id)
  end

  def authorize_rooms
    authorize Room
  end

end