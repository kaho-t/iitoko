RSpec.describe 'Scores', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:score) { FactoryBot.build(:score, user: user) }
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
    score.save
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
    expect(page).to have_current_path user_path
    tds = page.all('td')
    expect(tds[0]).to have_content '5'
  end
  # it 'doesnt show link to edit_score_path when the page isnt current_users page' do
  #   anothers_score.save
  #   sign_in user
  #   visit user_path(another_user)
  #   expect(page).to have_content '登録スコア'
  #   expect(page).to_not have_content 'スコア編集'
  # end
end