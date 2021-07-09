require 'rails_helper'

RSpec.describe 'Locals', type: :request do
  let(:local) { FactoryBot.create(:local) }
  before do
    local.confirm
    local.reload
  end

  describe 'GET /show' do
    it 'returns http success' do
      get local_path(local)
      expect(response).to have_http_status(:success)
    end
  end
end
