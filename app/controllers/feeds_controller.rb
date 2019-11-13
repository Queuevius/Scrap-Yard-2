class FeedsController < ApplicationController
  layout 'profiles'

  after_action :authorize_feed, only: [:index]

  def index
    policy_scope(Feed) if current_user

    @feed = Feed.all
  end

  private

  def authorize_feed
    authorize Feed
  end
end
