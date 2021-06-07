RSpec.describe 'Profiles', type: :system do
  let(:local) { FactoryBot.create(:local) }
  let(:profile) { FactoryBot.build(:profile, local: local)}
  let(:user) { FactoryBot.create(:user) }
  let(:another_local) { FactoryBot.create(:local, email: 'another@example.com') }
  before do
    local.confirm
    @number_of_profiles = Profile.count
  end

  describe 'creating a profile' do
    it 'success to create a profile' do
      sign_in local
      visit new_profile_path
      fill_in '人口', with: profile.population
      fill_in '平均気温', with: profile.temperature
      fill_in '転入数（前年）', with: profile.moved_in
      fill_in '待機児童数', with: profile.waiting_children
      fill_in '地価', with: profile.land_price
      fill_in '平均所得', with: profile.income
      fill_in '犯罪率', with: profile.crime_rate
      fill_in '町の紹介文', with: profile.introduction
      click_button '次へ'
      expect(Profile.count).to eq @number_of_profiles + 1
      expect(page).to have_current_path new_tag_path
      visit local_path(local)
      expect(page).to have_content "#{profile.introduction}"
    end

    it 'can create a profile without some data' do
      sign_in local
      visit new_profile_path
      fill_in '人口', with: nil
      fill_in '平均気温', with: profile.temperature
      fill_in '転入数（前年）', with: profile.moved_in
      fill_in '待機児童数', with: profile.waiting_children
      fill_in '地価', with: profile.land_price
      fill_in '平均所得', with: profile.income
      fill_in '犯罪率', with: profile.crime_rate
      fill_in '町の紹介文', with: profile.introduction
      click_button '次へ'
      expect(Profile.count).to eq @number_of_profiles + 1
      visit local_path(local)
      expect(page).to have_content "#{profile.introduction}"
      expect(page).to have_selector 'td', text: 'coming soon...'
    end

    it 'fails to create profile with invalid data' do
      sign_in local
      visit new_profile_path
      fill_in '人口', with: -1
      fill_in '平均気温', with: 1000
      fill_in '転入数（前年）', with: -1
      fill_in '待機児童数', with: -1
      fill_in '地価', with: -1
      fill_in '平均所得', with: -1
      fill_in '犯罪率', with: -1
      fill_in '町の紹介文', with: "a" * 1000
      click_button '次へ'
      expect(Profile.count).to eq @number_of_profiles
      expect(page).to have_current_path '/profiles'
      expect(page).to have_content "8 箇所のエラーがあります。"
    end
  end

  describe 'editing a profile' do
    it 'edit a profile' do
      profile.save
      sign_in local
      visit local_path(local)
      click_link '町のプロフィール編集'
      fill_in '人口', with: 200
      fill_in '平均気温', with: 15
      fill_in '転入数（前年）', with: 100
      fill_in '待機児童数', with: 50
      fill_in '地価', with: 2000000
      fill_in '平均所得', with: 5000000
      fill_in '犯罪率', with: 0.9
      fill_in '町の紹介文', with: '北区はよりいい街に！'
      click_button '確定'
      expect(page).to have_current_path local_path(local)
      expect(page).to have_content '北区はよりいい街に！'
    end
    it 'redirects to top when signed in with another account' do
      profile.save
      another_local.confirm
      sign_in another_local
      visit edit_profile_path(profile)
      expect(page).to have_current_path top_path
    end
  end
end