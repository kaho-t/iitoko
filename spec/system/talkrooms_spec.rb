RSpec.describe 'Talkrooms', js: true, type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:talkroom) { FactoryBot.build(:talkroom, user: user, local: local) }
  let(:message) { FactoryBot.build(:message, talkroom: talkroom) }

  before do
    user.confirm
    local.confirm
  end

  it 'creates talk room' do
    sign_in user
    visit local_path(local)
    expect do
      click_button '話を聞いてみたい'
    end.to change(Talkroom, :count).by(1).and change(Notification, :count).by(1)
  end

  it 'shows talk rooms' do
    sign_in user
    talkroom.save
    visit talkrooms_path
    expect(page).to have_content local.name
  end

  it 'deletes an talkroom' do
    talkroom.save
    sign_in user
    visit talkrooms_path
    expect(page).to have_content local.name
    expect do
      accept_alert do
        click_link 'トークルームを削除'
      end
      expect(page).to have_current_path talkrooms_path
    end.to change(Talkroom, :count).by(-1)
  end
end
