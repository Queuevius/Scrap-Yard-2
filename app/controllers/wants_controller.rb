class WantsController < ApplicationController
  layout 'profiles'

  before_action :set_want, only: [:edit, :update, :index]
  before_action :set_user, only: [:show, :index]

  after_action :authorize_want, only: [ :index, :show, :update, :edit, :new, :create, :destroy, :profile_want]

  def index
    policy_scope(Have) if current_user

    @want = Want.where(user_id: current_user.id)
  end

  def show
    policy_scope(Have) if current_user

    @want = Want.where(:user_id => params[:id])
  end

  def profile_want
    @want = Want.find(params[:id])

    @disable_sidebar = true

    @wants_attachment = @want.wants_attachments.all
  end

  def new
    @want = Want.new

    @disable_sidebar = true

    @wants_attachment = @want.wants_attachments.build
  end

  def create
    @want = Want.new(params.required(:want).permit(:user_id, :title, :description, :price, wants_attachments_attributes: [:id, :want_id, :image]))

    @want.user_id = current_user.id

    if @want.save
      params[:wants_attachments]['image'].each do |a|
        @wants_attachment = @want.wants_attachments.create!(:image => a)
      end
      redirect_to want_path(current_user.id)
    else
      render :new
    end
  end

  def edit
    @disable_sidebar = true
  end

  def update
    if @want.update(params.required(:want).permit(:user_id, :title, :description, :price, wants_attachments_attributes: [:id, :want_id, :image]))
      redirect_to profile_want_path(@want)
    else
      render :edit
    end
  end

  def destroy
    @want = Want.find(params[:id])
    @want.destroy

    @want.delete
    redirect_to want_path(current_user.id), notice: "Your post was deleted successfully"
  end

  private

  def authorize_want
    authorize Want
  end

  def set_want
    @want = Want.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

end