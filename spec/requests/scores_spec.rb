require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    @user.reload
    @score = FactoryBot.create(:score)
  end
  describe 'GET /new' do
    it 'returns http success' do
      sign_in @user
      get '/scores/new'
      expect(response).to have_http_status(:success)
    end
    it 'requires login without sign in' do
      get '/scores/new'
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      sign_in @user
      get edit_score_path(@score)
      expect(response).to have_http_status(:success)
    end
    it 'requires login without sign in' do
      get edit_score_path(@score)
      expect(response).to have_http_status(302)
    end
  end
end
