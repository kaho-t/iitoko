require 'rails_helper'

RSpec.describe 'Recommends', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/recommends/index'
      expect(response).to have_http_status(:success)
    end
  end
end
