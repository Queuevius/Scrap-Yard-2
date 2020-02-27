class TimeBanksController < ApplicationController

  after_action :authorize_time_banks, only: [:index]

  def index
    policy_scope(Profile) if current_user
  end

  private

  def authorize_time_banks
    authorize TimeBank
  end
end
