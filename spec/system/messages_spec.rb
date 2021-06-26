RSpec.describe 'Messages', js: true, type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local)}
  let(:talkroom) { FactoryBot.build(:talkroom, user: user, local: local)}
  let(:message) { FactoryBot.build(:message, talkroom: talkroom, sent_from: user.id)
 }

  before do
    user.confirm
    local.confirm
  end

  it 'creates a new message' do
    sign_in user
    visit local_path(local)
    click_button '話を聞いてみたい'
    expect{
      select '資料請求したい', from: 'カテゴリ'
      fill_in with:'子育て支援や保育園の情報がわかる資料があればいただきたいです。'
      click_button '送信'
      talkroom = Talkroom.last
      expect(page).to have_content local.name
  }.to change(Message, :count).by(1)
  end
  it 'delete a message' do
    talkroom.save
    message.save
    sign_in user
    visit talkroom_messages_path(talkroom)
    expect{
      accept_alert do
        click_link '削除'
      end
      expect(page).to have_current_path talkroom_messages_path(talkroom)
      expect(page).to have_no_content message.content
    }.to change(Message, :count).by(-1)
  end
end