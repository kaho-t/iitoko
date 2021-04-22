require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe 'GET /new' do
    it 'returns http success' do
      get '/users/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'redirects show when not logged in' do
      get user_path(user)
      expect(response).to redirect_to login_path
    end
  end

  describe 'GET /edit' do
    it 'redirects edit when not logged in' do
      get edit_user_path(user)
      expect(response).to redirect_to login_path
    end
  end

  describe 'PATCH /update' do
    it 'redirects update when not logged in' do
      patch user_path(user)
      expect(response).to redirect_to login_path
    end
  end

  describe 'DELETE /destroy' do
    it 'redirects destroy when not logged in' do
      delete user_path(user)
      expect(response).to redirect_to login_path
    end
  end
end
