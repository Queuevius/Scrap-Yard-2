class VideosController < ApplicationController
  layout 'profiles'

  before_action :set_video, only: [:edit, :update, :index]
  before_action :set_user, only: [:show, :index]

  after_action :authorize_video, only: [:index, :show, :create, :update, :edit, :new, :destroy, :show_video]

  def index
    policy_scope(Video) if current_user

    @video = Video.all.sort_by{|e| e["created_at DESC"]}
  end

  def show_video
    @disable_sidebar = true

    @video = Video.find(params[:id])
  end

  def show
    policy_scope(Video) if current_user

    @video = Video.where(:user_id => params[:id])
  end

  def new
    @disable_sidebar = true

    @video = Video.new
  end

  def create
    @video = Video.create(params.require(:video).permit(:title, :video, :description, :user_id))

    @video.user_id = current_user.id

    if @video.save!
      redirect_to video_path(current_user.id)
    else
      render :new
    end
  end

  def edit
    @disable_sidebar = true
  end

  def update
    if @video.update(params.required(:video).permit(:name, :video, :description, :user_id))
      redirect_to show_video_path(@video)
    else
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    @video.delete
    redirect_to video_path(@video.user_id), notice: "Your video was deleted successfully"
  end

  private

  def authorize_video
    authorize Video
  end

  def set_video
    @video = Video.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
