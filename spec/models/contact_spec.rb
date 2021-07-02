require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryBot.build(:contact)}


  it 'has a valid factory' do
    expect(FactoryBot.build(:contact)).to be_valid
  end
  it 'is invalid without email address' do
    contact.email = nil
    contact.valid?
    expect(contact.errors[:email]).to include('を入力してください')
  end
  it 'is invalid with invalid email address' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      contact.email = invalid_address
      contact.valid?
      expect(contact.errors[:email]).to include('は不正な値です')
    end
  end
  it 'is invalid without category' do
    contact.category = nil
    contact.valid?
    expect(contact.errors[:category]).to include('を入力してください')
  end
  it 'is invalid with too long categpry' do
    contact.category = "a" * 51
    contact.valid?
    expect(contact.errors[:category]).to include('は50文字以内で入力してください')
  end

  it 'is invalid with too long content' do
    contact.content = "a" * 256
    contact.valid?
    expect(contact.errors[:content]).to include("は255文字以内で入力してください")
  end

end
