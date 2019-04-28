class CommentsController < ApplicationController

	before_action :authenticate_user!

	after_action :authorize_comment, only: [ :create]

	def create   
		Comment.create!( com_body: params[:body] , token_id: params[:token_id].to_i , polarity: params[:polarity], creator_id: current_user.id )
		redirect_to "/posts/#{params[:id]}/show_token?token_id=#{params[:token_id]}"
	end



	private 
  
  def authorize_comment
  	authorize Comment
  end

end
