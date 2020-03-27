class PicsController < ApplicationController
  layout 'profiles'

  after_action :authorize_pic

  def index
    policy_scope(Pic) if current_user
    @pic = Pic.all.sort_by{|e| e["created_at DESC"]}
  end

  def show
    @pic = Pic.find(params[:id])
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

  def edit
    @pic = Pic.new
  end

  def update
    if @pic.update(params.required(:pic).permit(:name, :image, :description, :user_id))
      redirect_to @pic
    else
      render :edit
    end
  end

  def destroy
    @pic = Pic.find(params[:id])
    @pic.destroy

    @pic.delete
    redirect_to pics_path, notice: "Your picture was deleted successfully"
  end

  private

  def authorize_pic
    authorize Pic
  end
end
