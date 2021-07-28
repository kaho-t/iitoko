RSpec.describe 'Notifications', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }

  before do
    user.confirm
    local.confirm
  end

  it 'shows notification about bookmark' do
    sign_in user
    visit local_path(local)
    within 'div.left_btns' do
      find('.bookmark-btn').click
    end
    sign_out user

    sign_in local
    visit notifications_path
    expect(page).to have_content "#{user.name}さんが あなたをブックマークしました"
  end
end
