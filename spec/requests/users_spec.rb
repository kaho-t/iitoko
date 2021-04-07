require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/users/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    context 'when a user is present' do
      let(:user) { FactoryBot.create :user }
      it 'returns http success' do
        get user_url user.id
        expect(response).to have_http_status(:success)
      end
      it "shows user's name" do
        get user_url user.id
        expect(response.body).to include user.name
      end
    end
    context 'when the user is not present' do
      subject { -> { get user_url 1 } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET /edit' do
    context 'when a user is present' do
      let(:user) { FactoryBot.create :user }
      it 'returns http success' do
        get edit_user_url user
        expect(response).to have_http_status(:success)
      end
    end
  end
end
