class RoomsController < ApplicationController
  before_action :authorize_rooms, only: [:create, :new, :index, :edit, :update, :show]
  before_action :load_entities

  def index
    policy_scope(Room) if current_user

    @users = User.all.where.not(id: current_user)

    @rooms = Room.all
  end

  def show
    @message = Message.new room: @room
    @messages = @room.messages.includes(:user)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new permitted_parameters

    if @room.save
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def edit
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
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
    @name = [current_user.first_name, current_user.last_name].compact.join(' ')
  end

  def permitted_parameters
    params.require(:room).permit(:name, :sender_id, :reciever_id)
  end

  def authorize_rooms
    authorize Room
  end

end