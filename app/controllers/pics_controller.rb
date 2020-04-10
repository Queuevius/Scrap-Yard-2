class PicsController < ApplicationController
  layout 'profiles'

  before_action :set_picture, only: [:edit, :update, :index]
  before_action :set_user, only: [:show, :index]

  after_action :authorize_pic

  def index
    policy_scope(Pic) if current_user

    @user = User.friendly.find(params[:id])

    @pic = Pic.find(params[:id]).sort_by{|e| e["created_at DESC"]}
  end

  def show
    policy_scope(Pic) if current_user

    @user = User.friendly.find(params[:id])

    @pic = Pic.where(:user_id => params[:id])
  end

  def solo_pic
    @disable_sidebar = true

    @pic = Pic.find(params[:id])

    @user = User.friendly.find(params[:id])
  end

  def new
    @disable_sidebar = true

    @pic = Pic.new
  end

  def create
    @pic = Pic.new(params.require(:pic).permit(:name, :image, :description, :user_id))

    @pic.user_id = current_user.id

    if @pic.save!
      redirect_to pic_path(current_user.id)
    else
      render :new
    end
  end

  def edit
    @disable_sidebar = true
  end

  def update
    if @pic.update(params.required(:pic).permit(:name, :image, :description, :user_id))
      redirect_to solo_pic_path(@pic)
    else
      render :edit
    end
  end

  def destroy
    @pic = Pic.find(params[:id])
    @pic.destroy

    @pic.delete
    redirect_to pic_path(@pic.user_id), notice: "Your picture was deleted successfully"
  end

  private

  def authorize_pic
    authorize Pic
  end

  def set_picture
    @pic = Pic.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
