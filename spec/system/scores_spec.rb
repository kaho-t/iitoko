RSpec.describe 'Scores', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:user_score) { FactoryBot.build(:score, user: user, local: nil) }
  let(:local_score) { FactoryBot.build(:score, user: nil, local: local) }

  describe 'User' do
    before do
      user.confirm
      user.reload
    end
    it 'creates a score' do
      sign_in user
      visit welcome_path
      click_link '＞＞住みたいトコ、ドンナトコ？'
      choose 'score_nature_1'
      choose 'score_accessibility_2'
      choose 'score_budget_3'
      choose 'score_job_support_4'
      choose 'score_family_support_5'
      choose 'score_culture_0'
      click_button '次へ'
      #expect(page).to have_current_path 'new_tags_path'
      visit user_path(user)
      expect(page).to have_content '登録スコア'
    end
    it 'shows link to new_score_path when a user doesnt have any score' do
      sign_in user
      visit user_path(user)
      expect(page).to_not have_content '登録スコア'
      expect(page).to have_content '移住に求める条件を登録しましょう'
    end
    it 'updates scores' do
      user_score.save
      sign_in user
      visit user_path(user)
      click_link 'スコア編集'
      expect(page).to have_content 'スコアを編集する'
      choose 'score_nature_5'
      choose 'score_accessibility_5'
      choose 'score_budget_5'
      choose 'score_job_support_5'
      choose 'score_family_support_5'
      choose 'score_culture_5'
      click_button '変更'
      expect(page).to have_current_path user_path(user)
      tds = page.all('td')
      expect(tds[0]).to have_content '5'
    end
    it 'doesnt show link to locals edit_score_path' do
      local_score.save
      sign_in user
      visit local_path(local)
      expect(page).to have_content '登録スコア'
      expect(page).to_not have_content 'スコア編集'
    end
  end
  describe 'Loocal' do
    before do
      local.confirm
      local.reload
    end
    it 'creates a score' do
      sign_in local
      visit local_path(local)
      expect(page).to have_content 'あなたの町がドンナトコか登録しましょう'
      visit welcome_path
      click_link '＞＞あなたの町、ドンナトコ？'
      choose 'score_nature_1'
      choose 'score_accessibility_2'
      choose 'score_budget_3'
      choose 'score_job_support_4'
      choose 'score_family_support_5'
      choose 'score_culture_0'
      click_button '次へ'
      visit local_path(local)
      expect(page).to have_content '登録スコア'
      expect(page).to have_content 'スコア編集'
    end
    it 'shows link to new_score_path when a user doesnt have any score' do
      sign_in local
      visit local_path(local)
      expect(page).to_not have_content '登録スコア'
      expect(page).to have_content 'あなたの町がドンナトコか登録しましょう'
    end
    it 'updates scores' do
      local_score.save
      sign_in local
      visit local_path(local)
      click_link 'スコア編集'
      expect(page).to have_content 'スコアを編集する'
      choose 'score_nature_5'
      choose 'score_accessibility_5'
      choose 'score_budget_5'
      choose 'score_job_support_5'
      choose 'score_family_support_5'
      choose 'score_culture_5'
      click_button '変更'
      expect(page).to have_current_path local_path(local)
      tds = page.all('td')
      expect(tds[0]).to have_content '5'
    end
    it 'doesnt see users score editor link' do
      user_score.save
      sign_in local
      visit user_path(user)
      expect(page).to_not have_content 'スコア編集'
    end
  end
end