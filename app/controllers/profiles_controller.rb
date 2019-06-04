class ProfilesController < ApplicationController

  layout 'profiles'

	before_action :authenticate_user!

	after_action :authorize_profile, only: [ :show, :update, :edit]

  def show
  	@user = User.friendly.find(params[:id])
    @profile = @user.profile
  end

  def update
  end

  def edit
  	@profile = current_user.profile
  end





  private 
  
  def authorize_profile
  	authorize Profile
  end

end
