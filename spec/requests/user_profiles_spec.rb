require 'rails_helper'

RSpec.describe 'UserProfiles', type: :request do
  let(:user) { FactoryBot.create(:user) }
  before do
    user.confirm
    sign_in user
  end
  describe 'GET /new' do
    it 'returns http success' do
      get '/user_profiles/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      user_profile = FactoryBot.create(:user_profile, user: user)
      get edit_user_profile_path(user_profile)
      expect(response).to have_http_status(:success)
    end
  end
end
