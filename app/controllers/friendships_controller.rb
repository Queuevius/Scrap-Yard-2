class FriendshipsController < ApplicationController
  before_action :authorize_friendships, only: [:create, :destroy]

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to profile_path(current_user)
    else
      flash[:error] = "Unable to add friend."
      redirect_to profile_path(current_user)
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
