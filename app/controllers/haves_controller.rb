class HavesController < ApplicationController
  layout 'profiles'

  before_action :set_have, only: [:edit, :update, :index]
  before_action :set_user, only: [:show, :index]

  after_action :authorize_have, only: [ :index, :show, :update, :edit, :new, :create, :destroy, :profile_have]

  def index
    policy_scope(Have) if current_user

    @have = Have.where(user_id: current_user.id)

  end

  def show
    policy_scope(Have) if current_user

    @have = Have.where(:user_id => params[:id])
  end

  def profile_have
    @have = Have.find(params[:id])

    @disable_sidebar = true

    @have_attachment = @have.have_attachments.all
  end

  def new
    @disable_sidebar = true

    @have = Have.new

    @have_attachment = @have.have_attachments.build

  end

  def create
    @have = Have.new(params.required(:have).permit(:user_id, :title, :description, :price, have_attachments_attributes: [:id, :have_id, :image]))

    @have.user_id = current_user.id

    if @have.save
      params[:have_attachments]['image'].each do |a|
        @have_attachment = @have.have_attachments.create!(:image => a)
      end
      redirect_to profile_have_path(@have)
    else
      render :new
    end
  end

  def edit
    @disable_sidebar = true
  end

  def update
    if @have.update(params.required(:have).permit(:user_id, :title, :description, :price, have_attachments_attributes: [:id, :have_id, :image]))
      params[:have_attachments]['image'].each do |a|
        @have_attachment = @have.have_attachments.create!(:image => a)
      end
      redirect_to profile_have_path(@have)
    else
      render :edit
    end
  end

  def destroy
    @have = Have.find(params[:id])
    @have.destroy

    @have.delete
    redirect_to hafe_path(current_user.id), notice: "Your post was deleted successfully"
  end

  private

  def authorize_have
    authorize Have
  end

  def set_have
    @have = Have.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  end