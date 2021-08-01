RSpec.describe 'Footprints', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }

  before do
    user.confirm
    local.confirm
  end

  it 'make footprints when user visit local_page' do
    sign_in user
    expect do
      visit local_path(local)
      visit home_path
      visit local_path(local)
      expect(page).to have_selector 'h1', text: local.name
    end.to change(Footprint, :count).by(1)
    sign_out user
    sign_in local
    visit notifications_path
    expect(page).to have_content "#{user.name}さんが あなたのページを訪問しました"
  end
  it 'make footprints when local visit user_page' do
    sign_in local
    expect do
      visit user_path(user)
      expect(page).to have_content user.name
      visit local_path(local)
      visit user_path(user)
      expect(page).to have_content user.name
    end.to change(Footprint, :count).by(1)
    sign_out local
    sign_in user
    visit notifications_path
    expect(page).to have_content 'あなたのページを訪問しました'
  end
end
