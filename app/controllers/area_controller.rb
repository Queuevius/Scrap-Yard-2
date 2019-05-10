class AreaController < ApplicationController
  
	#before_action :authorize_tag, only: [:new, :create]
	before_action :authenticate_user!

	before_action :initialize_area, only: [:show , :new_layer, :create_layer ]

	after_action :authorize_tag, only: [:new, :create, :show, :new_layer, :create_layer]

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
  	unless params[:layer].blank?
			@clayer = @area.layers.find_by_name(params[:layer]) 
		else
			@clayer = nil
		end
		area_stats = @area.posts_count(@clayer.try(:id))
  	@area_stats = [ @area.name, 
					area_stats[0][1],
					area_stats[1][1],
					area_stats[2][1],
					@area.creator_id
				]				
		@layers = @area.layers - [@clayer]
  end

  def new_layer
  	#@area = Tag.where(id: params[:id]).first
  	@layer = 	@area.layers.build 
  end

  def create_layer
  	#@area = Tag.where(id: params[:id]).first
  	@layer = @area.layers.build(layer_params)
		@layer.creator_id = current_user.id
		if @layer.save
			redirect_to "/area/#{@area.name}"
		else 
			render :new_layer
		end

  end

  private 


  def initialize_area
  	@area = Tag.friendly.find_by_name(params[:id])
  end
  
  def authorize_tag
  	authorize Tag
  end



  def tag_params
  	params.require(:tag).permit(:name, :tag_body)
	end

	def layer_params
		params.require(:layer).permit(:name, :layer_body)
	end
end
