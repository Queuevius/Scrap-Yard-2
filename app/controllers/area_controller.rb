class AreaController < ApplicationController
  
	#before_action :authorize_tag, only: [:new, :create]
	before_action :authenticate_user!

	before_action :initialize_area, only: [:show , :new_layer, :create_layer ]

	after_action :authorize_tag, only: [:new, :create, :edit, :update, :show, :new_layer, :create_layer]

  skip_before_action :authenticate_user!, only: [:show, :index, :search_index]

  def new
  	@tag = Tag.new 
  end

  def create
  	@tag = Tag.create! tag_params 
  	@tag.creator_id = current_user.id 
  	@tag.save!
  	redirect_to posts_path 
	end

	def edit
		@ep  = Tag.find(params[:id])
		unless params[:layer_id].blank?
			@ep.tag_body =  @ep.layers.find_by_id(params[:layer_id]).layer_body
			@current_layer = @ep.layers.find_by_id(params[:layer_id])
		else
			@current_layer = nil
		end
	end

	def update
		@ep = Tag.find(params[:id])

		if params[:layer_id].blank?
			updated = @ep.update(tag_params)
		else
			updated = @ep.update(title: tag_params[:name])
			updated = @ep.layers.find_by_id(params[:layer_id]).update(layer_body: tag_params[:tag_body])
		end

		if updated
			redirect_to area_path(@ep)
		else
			render :edit
		end

		@delete = Tag.find(params[:id])

		if params[:layer_id].blank?
			updated = @delete.update(tag_params)
		else
			updated = @delete.update(title: tag_params[:name])
			updated = @delete.layers.find_by_id(params[:layer_id]).update(layer_body: tag_params[:tag_body])
		end

		if updated
			root_path
		else
			render :edit
		end
	end

  def show
		@area  = Tag.find(params[:id])
  	unless params[:layer].blank?
      @layers = @area.layers 
			@clayer = @area.layers.find_by_name(params[:layer]) 
			@posts = Post.joins(:taggings).where(taggings: { layer_id: @clayer.id }).type('Problem').with_tags(@area.name)
			@prop = Post.joins(:taggings).where(taggings: { layer_id: @clayer.id }).type('Proposal').with_tags(@area.name)
		else
      @layers = @area.layers - [@clayer]
			@posts = Post.joins(:taggings).where(taggings: { layer_id: nil }).type('Problem').with_tags(@area.name)
			@prop = Post.joins(:taggings).where(taggings: { layer_id: nil }).type('Proposal').with_tags(@area.name)
			@clayer = nil
		end
		area_stats = @area.posts_count(@clayer.try(:id))
  	@area_stats = [ @area.name, 
					area_stats[0][1],
					area_stats[1][1],
					area_stats[2][1],
					@area.creator_id
				]

		@delete  = Tag.find(params[:id])
		unless params[:layer_id].blank?
			@delete.tag_body =  @delete.layers.find_by_id(params[:layer_id]).layer_body
			@current_layer = @delete.layers.find_by_id(params[:layer_id])
		else
			@current_layer = nil
		end
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
  	@area = Tag.find_by_name(params[:id])
  end
  
  def authorize_tag
  	authorize Tag
  end

  def tag_params
  	params.require(:tag).permit(:name, :tag_body, :creator_id)
	end

	def layer_params
		params.require(:layer).permit(:name, :layer_body)
	end
end
