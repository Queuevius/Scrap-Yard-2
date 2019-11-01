class ProfilesController < ApplicationController

  layout 'profiles'

	before_action :authenticate_user!

	after_action :authorize_profile, only: [ :show, :update, :edit, :update_pic]

  before_action :set_s3_direct_post, only: [:show , :update_pic]

  skip_before_action :verify_authenticity_token, only: [:update_pic]


  def show
  	@user = User.friendly.find(params[:id])
    @profile = @user.profile
  end

  def update_pic
    avatar_url = "https://needpediasbucket.s3-us-west-2.amazonaws.com/users_display_pictures/#{current_user.id}/#{params[:avatar_url]}" 
    current_user.profile.update_attribute :avatar_url ,  avatar_url
    @user = current_user
    @profile = @user.profile
    render :show
  end

  def edit
  	@profile = current_user.profile
  end





  private 
  
  def authorize_profile
  	authorize Profile
  end

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "users_display_pictures/#{current_user.id}/${filename}", success_action_status: '200', acl: 'public-read')
  end

end
