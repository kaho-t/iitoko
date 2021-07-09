require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:bookmark) { FactoryBot.build(:bookmark, user: user, local: local) }

  before do
    user.confirm
    local.confirm
  end

  it 'has valid factory' do
    expect(bookmark.valid?).to be true
  end

  it 'makes and delete bookmark' do
    expect(user.bookmarking?(local)).to be false
    user.bookmark_local(local)
    expect(user.bookmarking?(local)).to be true
    user.unbookmark_local(local)
    expect(user.bookmarking?(local)).to be false
  end
end
