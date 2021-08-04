RSpec.describe 'Messages', js: true, type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:talkroom) { FactoryBot.build(:talkroom, user: user, local: local) }
  let(:message) do
    FactoryBot.build(:message, talkroom: talkroom, sender_id: user.id)
  end

  before do
    user.confirm
    local.confirm
  end

  it 'creates a new message' do
    sign_in user
    visit local_path(local)
    within 'div.left_btns' do
      click_button '話を聞いてみたい'
    end
    expect do
      select '資料請求したい', from: 'カテゴリ'
      fill_in with: '子育て支援や保育園の情報がわかる資料があればいただきたいです。'
      click_button 'メッセージを送る'
      expect(page).to have_content local.name
    end.to change(Message, :count).by(1).and change(Notification, :count).by(1)
  end
  it 'delete a message' do
    talkroom.save
    message.save
    sign_in user
    visit talkroom_messages_path(talkroom)
    expect do
      accept_alert do
        click_link '削除'
      end
      expect(page).to have_current_path talkroom_messages_path(talkroom)
      expect(page).to have_no_content message.content
    end.to change(Message, :count).by(-1)
  end
  it 'creates a message with attachment' do
    talkroom.save
    sign_in user
    visit talkroom_messages_path(talkroom)
    expect do
      select '質問がある', from: 'message[category]'
      fill_in with: 'ファイルを添付します'
      page.attach_file("#{Rails.root}/spec/files/attachment.jpeg") do
        page.find('.fa-image').click
      end
      page.attach_file("#{Rails.root}/spec/files/sumple.pdf") do
        page.find('.fa-paperclip').click
      end
      expect(page).to have_content '添付画像'
      expect(page).to have_content '添付ファイル'
      click_button '送信する'
    end.to change(Message, :count).by(1)
    expect(page).to have_css '.message_file_area'
    expect(page).to have_content 'ファイルを添付します'
    expect(page).to have_content '添付ファイル'
  end

end
