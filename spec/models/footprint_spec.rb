require 'rails_helper'

RSpec.describe Footprint, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }

  before do
    user.confirm
    local.confirm
  end

  it 'makes footprint by user' do
    expect(user.visited?(local)).to be false
    user.visit(local)
    expect(user.visited?(local)).to be true
    expect(user.visitedlocals).to include local
    expect(local.visitorusers).to include user
  end

  it 'makes footprint by local' do
    expect(local.visited?(user)).to be false
    local.visit(user)
    expect(local.visited?(user)).to be true
    expect(local.visitedusers).to include user
    expect(user.visitorlocals).to include local
  end
end
