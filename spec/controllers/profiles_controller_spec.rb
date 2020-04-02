require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe "GET #solo_pic" do
    it "returns http success" do
      get :solo_pic
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

end
