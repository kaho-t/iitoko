require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe 'GET /login' do
    it 'returns http success' do
      get '/login'
      expect(response).to have_http_status(:success)
    end
  end
end
