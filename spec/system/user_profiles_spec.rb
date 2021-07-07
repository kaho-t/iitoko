RSpec.describe 'UserProfiles', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:another) { FactoryBot.create(:user)}

  before do
    user.confirm
  end
  describe 'creating a user_profile' do
    it 'creates a new profile' do
      sign_in user
      visit new_user_profile_path
      expect {
        select '東京都', from: '居住地'
        select '30', from: '年齢'
        fill_in '興味のある地域・検討中の地域', with: '沖縄県'
        fill_in '職業', with: '会社員'
        fill_in '家族構成', with: '3人家族（父、母、子一人）'
        select '3年以内', from: '移住を検討している時期'
        fill_in '移住を検討したきっかけ', with: 'リモートワークが始まったため'
        click_button '確定'
        expect(page).to have_current_path home_path
      }.to change(UserProfile, :count).by(1)
    visit user_path(user)
    expect(page).to have_content 'プロフィール'
    expect(page).to have_content '東京都'
    expect(page).to have_content '30代'
    expect(page).to have_content '沖縄'
    expect(page).to have_content '3人家族'
    expect(page).to have_content '3年以内' 
    expect(page).to have_content 'リモートワークが始まったため'
    end
  end

  describe 'editing a user_profile' do
    it 'updates a profile' do
      sign_in user
      user_profile = FactoryBot.create(:user_profile, user: user)
      visit user_path(user)
      click_link 'プロフィール編集'
      fill_in '興味のある地域・検討中の地域', with: '沖縄県、福岡県、宮崎県'
      click_button '確定'
      expect(page).to have_current_path user_path(user)
      expect(page).to have_content '沖縄県、福岡県、宮崎県'
    end

    it 'redirects to home page when accessed by invalid user' do
      another.confirm
      sign_in user
      user_profile = FactoryBot.create(:user_profile, user: another)
      visit user_path(another)
      expect(page).to have_no_content 'プロフィール編集'
      visit edit_user_profile_path(user_profile)
      expect(page).to have_current_path home_path
    end
  end
end