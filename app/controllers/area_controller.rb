class AreaController < ApplicationController
  
	#before_action :authorize_tag, only: [:new, :create]
	before_action :authenticate_user!

	after_action :authorize_tag, only: [:new, :create, :show]

  def new
  	@tag = Tag.new 
  end

  def create
  	@tag = Tag.create! tag_params 
  	@tag.creator_id = current_user.id 
  	@tag.save!
  	redirect_to posts_path 
  end

  def show
  	as = Tag.where(id: params[:id]).map do |_| 
				[ _.name, 
					_.posts.type('Problem').count,
					_.posts.type('Idea').count,
					_.posts.type('Proposal').count,
					_.creator_id
				]
		end
		@area_stats = as[0]
		@area = Tag.where(id: params[:id]).first
  end


  private 
  
  def authorize_tag
  	authorize Tag
  end



  def tag_params
  	params.require(:tag).permit(:name, :tag_body)
	end
end
