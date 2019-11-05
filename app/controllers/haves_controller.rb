class HavesController < ApplicationController
  layout 'profiles'
  after_action :authorize_have, only: [ :show, :update, :edit, :new]

  def index

  end

  def show

  end

  def new
    @have = Have.new
  end

  def create
    @have = Have.new(params.required(:have).permit(:user_id, :title, :description))

    @have.user_id = current_user.id

    if @have.save
      redirect_to profile_haves_path
    else
      render :new
    end
  end

  def edit
    @have = Have.new
  end

  def update
    if @have.update(params.required(:have).permit(:user_if, :title, :description))
      redirect_to @store
    else
      render :edit
    end
  end

  private

  def authorize_have
    authorize Have
  end


  end