RSpec.describe 'Bookmarks', js: true, type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }

  before do
    user.confirm
    local.confirm
  end


  it 'add and delete local to bookmarklists' do
    sign_in user
    visit local_path(local)
    find(".bookmark-btn").click
    expect(page).to have_css '.bookmarked-btn'
    visit bookmarks_user_path(user)
    expect(page).to have_content local.name
    visit bookmarks_local_path(local)
    expect(page).to have_content user.name

    visit local_path(local)
    find(".bookmarked-btn").click
    expect(page).to have_css '.bookmark-btn'
    visit bookmarks_user_path(user)
    expect(page).to have_no_content local.name
    visit bookmarks_local_path(local)
    expect(page).to have_no_content user.name
  end

end