class PicsController < ApplicationController
  layout 'profiles'

  after_action :authorize_pic

  def index
    policy_scope(Pic) if current_user
    @pic = Pic.all
  end

  def show

  end

  def new
    @pic = Pic.new

  end

  def create
    @pic = Pic.new(params.require(:pic).permit(:name, :image, :description, :user_id))

    @pic.user_id = current_user.id

    if @pic.save!
      redirect_to pics_path
    else
      render :new
    end
  end

  def update

  end

  def edit

  end

  private

  def authorize_pic
    authorize Pic
  end
end
