require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local)}
  let(:talkroom) { FactoryBot.build(:talkroom, user: user, local: local)}
  let(:message) { FactoryBot.build(:message, talkroom: talkroom) }

  before do
    user.confirm
    local.confirm
    talkroom.save
  end

  it 'has valid factory' do
    expect(message).to be_valid
  end

  it 'is deleted when talkroom was deleted' do
    expect {
      message.save
    }.to change(Message, :count).by(1)
    expect {
      talkroom.destroy
    }.to change(Message, :count).by(-1)
  end

  describe 'validations' do
    it 'is invalid without category' do
      message.category = nil
      message.valid?
      expect(message.errors[:category]).to include('を入力してください')
    end

    it 'is invalid with too long category' do
      message.category = 'a' * 51
      message.valid?
      expect(message.errors[:category]).to include('は50文字以内で入力してください')
    end
  end

end
