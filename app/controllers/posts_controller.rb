class PostsController < ApplicationController

	before_action :authenticate_user!
	before_action :authorize_post, only: [:public_feed, :new_design, :new, :create, :edit, :update, :destroy, :show, :new_layer, :create_layer, :create_token, :all_tokens, :show_token, :add_rating, :homepage, :messages]
	after_action :set_tag_creator, :set_area_layer_assoc, only: [:create]
	skip_before_action :authenticate_user!, only: [:show, :index, :search_index, :show_token, :area_index, :area_layer, :homepage, :public_feed]

	skip_after_action :verify_policy_scoped, only: [:show, :index, :search_index, :show_token, :area_index, :area_layer, :homepage]

	def homepage

	end

	def new_design
		_layout = nil
	end

	def public_feed
		policy_scope(Profile) if current_user

    @feed = Tag.all.sort_by{|e| e["created_at DESC"]}

		@area = Tag.find_by_name(params[:tags_filter])
	end

	def index
		@show_search = true 
		policy_scope(Post) if current_user
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
			@area = Tag.find_by_name(params[:tags_filter].strip.split(',').first)
			if params[:parent_id]
				@parent_id = params[:parent_id].to_i
				@parent_post = Post.find_by_id @parent_id
				@has_parent = true 	
				@posts = Post.type(params[:post_type]).with_tags([params[:tags_filter]]).where(parent_post_id: params[:parent_id].to_i)
				@tags_count = [[ @parent_post.title , @posts.count]]
			elsif !(params[:area_layer].blank?)
				area_layer = @area.layers.find_by_name( params[:area_layer] )
				@posts = Post.joins(:taggings).where(taggings: { layer_id: area_layer.id }).type(params[:post_type]).with_tags([params[:tags_filter]])
				@tags_count = Tag.where(name: @area).map{|_|  [_.name, _.posts.type(params[:post_type]).count] }
			else
				@tags_count = Tag.where(name: @area).map{|_|  [_.name, _.posts.type(params[:post_type]).count] }
				@posts = Post.joins(:taggings).where(taggings: { layer_id: nil }).type(params[:post_type]).with_tags([params[:tags_filter]])
			end
			@all_tags = Tag.all.map { |_| [ _.name ] }
		end

	end

	def messages
		session[:rooms] ||= []

		@users = User.all.where.not(id: current_user)
		@conversations = Room.includes(:recipient, :messages)
												 .find(session[:rooms])
	end

	def search_index
	end

	def new
		@post = Post.new
		@post.post_type = params[:post_type]
		@post.all_tags=params[:area] if params[:area]
		@post.parent_post_id = params[:parent_post_id].to_i if params[:parent_post_id]
		@area_layer = params[:area_layer]
	end


	def edit 
		@ep  = Post.friendly.find(params[:id])
		unless params[:layer_id].blank?
			@ep.post_body =  @ep.layers.find_by_id(params[:layer_id]).layer_body
			@current_layer = @ep.layers.find_by_id(params[:layer_id])
		else
			@current_layer = nil
		end
	end

	def update
		@post  = Post.friendly.find(params[:id])
		
		if params[:layer_id].blank?
			updated = @post.update(post_params)
		else
			updated = @post.update(title: post_params[:title]) 
			updated = @post.layers.find_by_id(params[:layer_id]).update(layer_body: post_params[:post_body])
		end			

		if updated
			redirect_to post_path @post
		else 
			render :edit
    end

    @delete  = Post.friendly.find(params[:id])

    if params[:layer_id].blank?
      updated = @delete.update(post_params)
    else
      updated = @delete.update(title: post_params[:title])
      updated = @delete.layers.find_by_id(params[:layer_id]).update(layer_body: post_params[:post_body])
    end

    if updated
      root_path
    else
      render :edit
    end
	end

	def destroy

	end


	def create
		@post = Post.new(post_params)
		@post.creator_id = @current_user.id  
		if @post.save
			Notification.create!(recipient_id: @post.area.creator_id, actor_id: current_user.id, action: "post", notifiable: @post)
			redirect_to post_path @post
		else 
			render :new
		end
	end

	def show
		@track = Tracking.new
		@post  = Post.friendly.find(params[:id])
		if user_signed_in?
			@rated = Rating.where({rateable_id: @post.id, rateable_type: @post.class.to_s, creator_id: current_user.id}).first
			@tokens_count = current_user.remaining_token_limit

			Notification.where(notifiable_id: @post.id).where(recipient_id: current_user.id).where(read_at: nil).each do |t|
				t.update!(read_at: Time.now)
			end
		end
		@layers = @post.layers
		if params[:layer]
			@current_layer = @post.layers.find_by_name(params[:layer]) 
		else
			@current_layer = nil
    end

    @delete  = Post.friendly.find(params[:id])
    unless params[:layer_id].blank?
      @delete.post_body =  @delete.layers.find_by_id(params[:layer_id]).layer_body
      @current_layer = @delete.layers.find_by_id(params[:layer_id])
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
		@layer = @post.layers.build(layer_params)
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
		if @token.save 
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
		redirect_to "/posts/#{@post.slug}"
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
		@comments = @token.comments.order(cached_votes_total: :desc)
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
			@comments = a.map!{|_| _.sort_by{ |p| [ p.cached_votes_total ] }.reverse!   }
		end
	end


private

def set_tag_creator
	@post.area.creator_id = current_user.id 
	@post.area.save
end

def set_area_layer_assoc
	area_layer = @post.area.layers.find_by_name( params[:post][:area_layer] )
	tagging = Tagging.last
	unless params[:post][:area_layer].blank?
		tagging.layer_id = area_layer.id
		tagging.save
	end
end

def post_params
  params.require(:post).permit(:title, :post_body, :all_tags,:post_type, :parent_post_id, feed_attributes: [:post_id, :post_type])
end

def layer_params
	params.require(:layer).permit(:name, :layer_body)
end

def authorize_post
	authorize Post
end


end







