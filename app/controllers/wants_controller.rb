class WantsController < ApplicationController
  layout 'profiles'
  after_action :authorize_want, only: [ :index, :show, :update, :edit, :new, :create, :destroy]

  def index
    policy_scope(Have) if current_user

    @want = Want.where(user_id: current_user.id)
  end

  def show
    @want = Want.find(params[:id])

    @wants_attachment = @want.wants_attachments.all
  end

  def new
    @want = Want.new
    @wants_attachment = @want.wants_attachments.build
  end

  def create
    @want = Want.new(params.required(:want).permit(:user_id, :title, :description, :price, wants_attachments_attributes: [:id, :want_id, :image]))

    @want.user_id = current_user.id

    if @want.save
      params[:wants_attachments]['image'].each do |a|
        @wants_attachment = @want.wants_attachments.create!(:image => a)
      end
      redirect_to profile_wants_path
    else
      render :new
    end
  end

  def edit
    @want = Want.new
  end

  def update
    if @want.update(params.required(:have).permit(:user_if, :title, :description, :price, wants_attachments_attributes: [:id, :want_id, :image]))
      redirect_to @want
    else
      render :edit
    end
  end

  def destroy
    @want = Want.find(params[:id])
    @want.destroy

    @want.delete
    redirect_to wants_path, notice: "Your post was deleted successfully"
  end

  private

  def authorize_want
    authorize Want
  end


end