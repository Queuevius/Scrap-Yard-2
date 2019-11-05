class WantsController < ApplicationController
  layout 'profiles'
  after_action :authorize_want, only: [ :show, :update, :edit, :new]

  def index

  end

  def show

  end

  def new
    @want = Want.new
  end

  def create
    @want = Want.new(params.required(:want).permit(:user_id, :title, :description))

    @want.user_id = current_user.id

    if @want.save
      redirect_to profile_wants_path
    else
      render :new
    end
  end

  def edit
    @want = Want.new
  end

  def update
    if @want.update(params.required(:have).permit(:user_if, :title, :description))
      redirect_to profile_wants_path
    else
      render :edit
    end
  end

  private

  def authorize_want
    authorize Want
  end


end