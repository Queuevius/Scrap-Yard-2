class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_notifications, only: [:index, :mark_as_read, :update, :edit]

  def index
    policy_scope(Notification) if current_user

    @notifications = Notification.where(recipient: current_user).unread
  end

  def edit

  end

  def update
    if @notification.update(params.required(:notification).permit(:recipient_id, :actor_id,
                                                                  :read_at, :action, :notifiable_id, :room_id, :notifiable_type))
      redirect_to @notification
    else
      render root_path
    end
  end

  private

  def authorize_notifications
    authorize Notification
  end
end