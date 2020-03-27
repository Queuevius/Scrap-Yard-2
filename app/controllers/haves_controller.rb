class HavesController < ApplicationController
  layout 'profiles'
  after_action :authorize_have, only: [ :index, :show, :update, :edit, :new, :create, :destroy]

  def index
    policy_scope(Have) if current_user

    @have = Have.where(user_id: current_user.id)

  end

  def show
    @have = Have.find(params[:id])

    @have_attachment = @have.have_attachments.all
  end

  def new
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
      redirect_to haves_path
    else
      render :new
    end
  end

  def edit
    @have = Have.new
  end

  def update
    if @have.update(params.required(:have).permit(:user_if, :title, :description, :price, have_attachments_attributes: [:id, :have_id, :image]))
      redirect_to @have
    else
      render :edit
    end
  end

  def destroy
    @have = Have.find(params[:id])
    @have.destroy

    @have.delete
    redirect_to haves_path, notice: "Your post was deleted successfully"
  end

  private

  def authorize_have
    authorize Have
  end


  end