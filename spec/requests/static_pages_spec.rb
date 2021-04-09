require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /home_local' do
    it 'returns http success' do
      get '/static_pages/home_local'
      expect(response).to have_http_status(:success)
    end
  end
end
