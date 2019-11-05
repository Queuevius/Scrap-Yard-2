class TrackingsController < ApplicationController
  layout 'profiles'
  after_action :authorize_tracking, only: [ :index, :new]

  def index
    policy_scope(Tracking) if current_user

    @track = Tracking.where(user_id: current_user.id)
  end

  def new
    @track = Tracking.new
  end

  def create
    @track = Tracking.new(params.required(:tracking).permit(:user_id, :post_id))

    @track.user_id = current_user.id

    if @track.save
      redirect_to trackings_path
    else
      render :new
    end
  end

  private

  def authorize_tracking
    authorize Tracking
  end
end
