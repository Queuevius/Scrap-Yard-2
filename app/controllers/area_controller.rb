class AreaController < ApplicationController
  
	#before_action :authorize_tag, only: [:new, :create]
	before_action :authenticate_user!

	after_action :authorize_tag, only: [:new, :create]

  def new
  	@tag = Tag.new 
  end

  def create
  	@tag = Tag.create! tag_params 
  	redirect_to posts_path 
  end

  private 
  
  def authorize_tag
  	authorize Tag
  end

  def tag_params
  	params.require(:tag).permit(:name, :tag_body)
	end
end
