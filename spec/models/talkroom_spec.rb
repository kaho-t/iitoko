require 'rails_helper'

RSpec.describe Talkroom, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:talkroom) { FactoryBot.create(:talkroom, user: user, local: local) }

  before do
    user.confirm
    local.confirm
  end

  it 'is valid talkroom' do
    expect(talkroom).to be_valid
  end

  it 'shows who is talking with' do
    room = user.talkrooms.find(talkroom.id)
    expect(user.talking_withs.last).to eq local
    expect(local.talking_withs.last).to eq user
  end

  it 'is deleted when its talker was deleted' do
    expect {
      talkroom.save
    }.to change(Talkroom, :count).by(1)
    expect {
      user.destroy
    }.to change(Talkroom, :count).by(-1)
  end
end
