require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  let(:user_profile) { FactoryBot.build(:user_profile)}

  it 'has a valid factory' do
    expect(FactoryBot.create(:user_profile)).to be_valid
  end

  it 'is deleted when the user was deleted' do
    user = FactoryBot.create(:user)
    user_profile.user = user
    user_profile.save
    expect {
      user.destroy
    }.to change(UserProfile, :count).by (-1)
  end

  it 'is invalid with invalid prefecture_code' do
    user_profile.prefecture_code = 48
    user_profile.valid?
    expect(user_profile.errors[:prefecture_code]).to include('は47以下の値にしてください')
    user_profile.prefecture_code = 0
    user_profile.valid?
    expect(user_profile.errors[:prefecture_code]).to include('は1以上の値にしてください')
  end

  it 'is invalid with invalid age' do
    user_profile.age = 0
    user_profile.valid?
    expect(user_profile.errors[:age]).to include('は1以上の値にしてください')
    user_profile.age = 100
    user_profile.valid?
    expect(user_profile.errors[:age]).to include('は99以下の値にしてください')
  end

  it 'is invalid with invalid proposed_site' do
    user_profile.proposed_site = 'a' * 51
    user_profile.valid?
    expect(user_profile.errors[:proposed_site]).to include('は50文字以内で入力してください')
  end

  it 'is invalid with invalid job' do
    user_profile.job = 'a' * 51
    user_profile.valid?
    expect(user_profile.errors[:job]).to include('は50文字以内で入力してください')
  end
  it 'is invalid with invalid family_structure' do
    user_profile.family_structure = 'a' * 51
    user_profile.valid?
    expect(user_profile.errors[:family_structure]).to include('は50文字以内で入力してください')
  end
  it 'is invalid with invalid timing' do
    user_profile.timing = 'a' * 51
    user_profile.valid?
    expect(user_profile.errors[:timing]).to include('は50文字以内で入力してください')
  end
  it 'is invalid with invalid content' do
    user_profile.content = 'a' * 256
    user_profile.valid?
    expect(user_profile.errors[:content]).to include('は255文字以内で入力してください')
  end

end
