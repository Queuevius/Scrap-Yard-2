class PostsController < ApplicationController
	
	before_action :authenticate_user!
	before_action :authorize_post, only: [:new, :create, :show, :new_layer, :create_layer, :create_token, :all_tokens, :show_token, :add_rating]

	after_action :set_tag_creator, only: [:create]
	

	def index
		@show_search = true 
		policy_scope(Post)
		@ptype = params[:post_type] 			
		case params[:tags_filter]
		when nil
				#@ptype = "Area"
				@posts = []
				@all_tags = Tag.all.map do |_| 
				[ _.name, 
					_.posts.type('Problem').count,
					_.posts.type('Idea').count,
					_.posts.type('Proposal').count,
					_.id
				]
			end
		when 'search'
			term = @area = params[:term]
			@all_tags = Tag.where("name ILIKE ?","%#{term}%").map do |_| 
				[ _.name, 
					_.posts.type('Problem').count,
					_.posts.type('Idea').count,
					_.posts.type('Proposal').count
				]
			end 
			render :search_index
		else
			@show_search = false
			if params[:parent_id]
				@parent_id = params[:parent_id].to_i
				@parent_post = Post.find_by_id @parent_id
				@has_parent = true 	
				@posts = Post.type(params[:post_type]).with_tags([params[:tags_filter]]).where(parent_post_id: params[:parent_id].to_i)
				@tags_count = [[ @parent_post.title , @posts.count]]
			else
				@tags_count = Tag.where(name: @area).map{|_|  [_.name, _.posts.type(params[:post_type]).count] }
				@posts = Post.type(params[:post_type]).with_tags([params[:tags_filter]])
			end
			@all_tags = Tag.all.map { |_| [ _.name ] }
			@area = params[:tags_filter].strip.split(',').first
			@area = Tag.find_by_name(params[:tags_filter].strip.split(',').first)
			
		end
	end


	def search_index
	end

	def new
		@post = Post.new
		@post.post_type = params[:post_type]
		@post.all_tags=params[:area] if params[:area]
		@post.parent_post_id = params[:parent_post_id].to_i if params[:parent_post_id]
	end


	def create
		@post = Post.new(post_params)
		@post.creator_id = @current_user.id  
		if @post.save
			redirect_to post_path @post
		else 
			render :new
		end
	end

	def show
		@post  = Post.friendly.find(params[:id])
		@rated = Rating.where({rateable_id: @post.id, rateable_type: @post.class.to_s, creator_id: current_user.id}).first
		@layers = @post.layers
		if params[:layer]
			@current_layer = @post.layers.find_by_name(params[:layer]) 
		else
			@current_layer = nil
		end
	end

	def new_layer 
		@post = Post.friendly.find(params[:id])
		@layer = Layer.new
	end

	def create_layer
		@post = Post.friendly.find(params[:id])
		@layer = Post.friendly.find(params[:id]).layers.build(layer_params)
		@layer.creator_id = current_user.id
		if @layer.save
			redirect_to "#{post_path(@post)}?layer=#{@layer.name}"
		else 
			render :new_layer
		end
	end


	def create_token
		@post = Post.friendly.find(params[:id])
		@token = @post.tokens.build
		@token.token_type = params[:tkntype]
		@token.creator_id = current_user.id 
		@token.token_body = params[:token_body]
		@token.span_id = params[:span_id]
		unless params[:layer_id].blank?
			@token.layer_id = params[:layer_id].to_i 
		end
		if @token.save(validate: false) 
			token_path = "/posts/#{@post.slug}/show_token?token_id=#{@token.id}"
			render json: { add_token: true , token_path: token_path ,span_id: @token.span_id , type: @token.token_type }.to_json
		else
			render json: { add_token: false }.to_json
		end
	end


	def add_rating
		@post = Post.friendly.find(params[:id])
		score = params[:score].to_i
		rating = Rating.where({rateable_id: @post.id, rateable_type: @post.class.to_s, creator_id: current_user.id}).first_or_create
		rating.score = score
		rating.save
		render :show
	end

	def area_index 
	end

	def all_tokens
		@post = Post.friendly.find(params[:id])
		if params[:layer].blank?
			@tokens = @post.tokens.where(layer_id: nil)
		else
			@tokens = @post.tokens.where(layer_id: params[:layer])
		end
		render json: @tokens.to_json
	end

	def show_token
		@token = Token.find(params[:token_id]) 
		@comments = @token.comments
		if @token.token_type == 'Debate' && !(@comments.blank?)
			a = [[], [], []]
			@comments.inject(a) do |a,_|
		  	if _.polarity == 'yes'
		    	a[0].push(_)
		  	elsif _.polarity == 'no'
		    	a[1].push(_)
		  	else
		  		a[2].push(_)
		  	end  
		  	a
			end
			@comments = a
		end
		#@comment = @token.comments.build
	end


private

def set_tag_creator
	@post.area.creator_id = current_user.id 
	@post.area.save
end

def post_params
  params.require(:post).permit(:title, :post_body, :all_tags,:post_type, :parent_post_id)
end

def layer_params
	params.require(:layer).permit(:name, :layer_body)
end

def authorize_post
	authorize Post
end


end







