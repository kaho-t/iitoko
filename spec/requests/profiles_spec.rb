require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:local) { FactoryBot.create(:local) }

  before do
    local.confirm
  end
  describe "GET /new" do
    it "returns http success" do
      sign_in local
      get "/profiles/new"
      expect(response).to have_http_status(:success)
    end
    it "requires login without sign in" do
      get "/profiles/new"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /edit" do
    let(:profile) { FactoryBot.create(:profile, local: local) }
    it "returns http success" do
      sign_in local
      get edit_profile_path(profile)
      expect(response).to have_http_status(:success)
    end
    it "requires login without sign in" do
      get edit_profile_path(profile)
      expect(response).to have_http_status(302)
    end
  end
end
