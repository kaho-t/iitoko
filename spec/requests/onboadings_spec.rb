require 'rails_helper'

RSpec.describe "Onboadings", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    @user.reload
  end

  describe "GET /welcome" do
    it "returns http success" do
      sign_in @user
      get "/welcome"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      sign_in @user
      get "/donnatoko"
      expect(response).to have_http_status(:success)
    end
  end

end
