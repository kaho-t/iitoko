require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let(:local) { FactoryBot.create(:local) }
  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article, local: local) }
  let(:another_local) { FactoryBot.create(:local) }

  before do
    local.confirm
  end

  describe 'GET /index' do
    it 'returns http success' do
      user.confirm
      sign_in user
      get local_articles_path(local)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      local.confirm
      sign_in local
      get '/articles/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      local.confirm
      sign_in local
      get edit_article_path(article)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      local.confirm
      sign_in local
      get article_path(article)
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'from invalid account' do
  #   before do
  #     another_local.confirm
  #     article.save
  #   end
  #   it 'fails to edit' do
  #     article_params = FactoryBot.attributes_for(:article)
  #     sign_in another_local
  #     patch :update, params: { id: article.id, article: article_params }
  #     expect(page).to have_current_path top_path
  #   end
  #   it 'fails to delete' do
  #     sign_in another_local
  #     delete article
  #     expect(page).to have_current_path top_path
  #   end

  # end
end
