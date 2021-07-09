require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:notification) { FactoryBot.build(:notification) }

  it 'has a valid factory' do
    expect(notification.valid?).to be true
  end
end
