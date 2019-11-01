class CommentsController < ApplicationController

	before_action :authenticate_user!

	after_action :authorize_comment, only: [ :create, :add_vote]

	def create   
		Comment.create!( com_body: params[:body] , token_id: params[:token_id].to_i , polarity: params[:polarity], creator_id: current_user.id )
		redirect_to "/posts/#{params[:id]}/show_token?token_id=#{params[:token_id]}"
	end

	def add_vote
		@com = Comment.find_by_id params[:comment_id]
		case current_user.voted_as_when_voted_for(@com)
			when nil
				@com.vote_by :voter => current_user, :vote => params[:vote]
			when true 
				@com.unliked_by current_user
			else
				@com.undisliked_by current_user
			end
	end

	private 
  
  def authorize_comment
  	authorize Comment
  end

end
