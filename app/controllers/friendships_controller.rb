class FriendshipsController < ApplicationController
  before_action :authorize_friendships, only: [:create, :destroy]

  def create
    @friendship = Friendship.new(params.required(:friendship).permit(:user_id, :friend_id))

    if @friendship.save!
      redirect_back(fallback_location: profile_path(current_user))
    else
      render profile_path(@user.id)
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to profile_path(current_user)
  end

  private

  def authorize_friendships
    authorize Friendship
  end

end
