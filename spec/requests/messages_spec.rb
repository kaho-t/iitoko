require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:talkroom) { FactoryBot.build(:talkroom, user: user, local: local) }
  let(:message) { FactoryBot.build(:message, talkroom: talkroom) }

  before do
    user.confirm
    sign_in user
    local.confirm
    talkroom.save
  end

  describe 'GET /index' do
    it 'returns http success' do
      get talkroom_messages_path(talkroom)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_talkroom_message_path(talkroom)
      expect(response).to have_http_status(:success)
    end
  end
end
