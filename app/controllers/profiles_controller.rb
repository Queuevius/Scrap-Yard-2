class ProfilesController < ApplicationController
  layout 'profiles'
	before_action :authenticate_user!
	after_action :authorize_profile, only: [ :show, :update, :edit, :update_pic, :profile_posts, :profile_haves, :profile_wants]
  before_action :set_s3_direct_post, only: [:show , :update_pic]
  skip_before_action :verify_authenticity_token, only: [:update_pic]

  def index
    policy_scope(Profile) if current_user

    @posts = Post.all
    @wants = Want.all
    @haves = Have.all
    @pics = Pic.all
    @video = Video.all

    @feed = (@posts + @wants + @haves + @pics + @video).sort_by{|e| e[:created_at]}
  end

  def chat
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                         .find(session[:conversations])
  end

  def profile_posts
    policy_scope(Profile) if current_user

    @note = Post.where(creator_id: current_user.id, post_type: "")
  end

  def profile_haves
    @have = Have.where(user_id: current_user.id)
  end

  def profile_wants
    @have = Want.where(user_id: current_user.id)
  end

  def show
  	@user = User.friendly.find(params[:id])
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
