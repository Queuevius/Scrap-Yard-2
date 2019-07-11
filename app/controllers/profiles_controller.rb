class ProfilesController < ApplicationController

  layout 'profiles'

	before_action :authenticate_user!

	after_action :authorize_profile, only: [ :show, :update, :edit]

  before_action :set_s3_direct_post, only: [:show]



  def show
  	@user = User.friendly.find(params[:id])
    @profile = @user.profile
  end

  def update_pic
    byebug
  end

  def edit
  	@profile = current_user.profile
  end





  private 
  
  def authorize_profile
  	authorize Profile
  end

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

end
