require 'rails_helper'

RSpec.describe "Tags", type: :request do
  let(:local) { FactoryBot.create(:local) }
  let(:tag) { FactoryBot.create(:tag, local: local)}

  before do
    local.confirm
  end

  describe "GET /new" do
    it "returns http success" do
      sign_in local
      get "/tags/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      sign_in local
      get edit_tag_path(tag)
      expect(response).to have_http_status(:success)
    end
  end

end
