require 'rails_helper'

RSpec.describe 'Recommends', type: :request do
  describe 'GET /top' do
    before do
      @user = FactoryBot.create(:user)
      @user.confirm
      @user.reload
    end

    it 'returns http success' do
      sign_in @user
      get top_path
      expect(response).to have_http_status(:success)
    end
  end
end
