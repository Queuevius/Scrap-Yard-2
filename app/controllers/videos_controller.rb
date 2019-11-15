class VideosController < ApplicationController
  layout 'profiles'

  after_action :authorize_video, only: [:index, :show, :create, :update, :edit, :new]

  def index
    policy_scope(Video) if current_user

    @video = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(params.require(:video).permit(:title, :video, :description, :user_id))

    @video.user_id = current_user.id

    if @video.save!
      redirect_to videos_path
    else
      render :new
    end
  end

  def edit
    @video = Video.new
  end

  def update
    if @video.update(params.required(:video).permit(:name, :video, :description, :user_id))
      redirect_to @video
    else
      render :edit
    end
  end

  private

  def authorize_video
    authorize Video
  end
end
