class TimeBanksController < ApplicationController

  after_action :authorize_time_banks, only: [:index]

  def index
  end

  private

  def authorize_time_banks
    authorize TimeBank
  end
end
