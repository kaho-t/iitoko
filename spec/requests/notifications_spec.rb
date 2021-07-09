require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }

  before do
    user.confirm
    local.confirm
  end

  describe 'GET /index' do
    it 'returns http success' do
      sign_in local
      get '/notifications'
      expect(response).to have_http_status(:success)
    end
  end
end
