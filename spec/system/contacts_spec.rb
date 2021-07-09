RSpec.describe 'Contacts', js: true, type: :system do
  let(:contact) { FactoryBot.build(:contact) }

  it 'creates a new contact' do
    visit contact_path
    expect do
      select 'お問い合わせ', from: 'カテゴリ'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in '備考欄', with: '全て無料で使えますか？'
      click_button '送信'
      expect(page).to have_current_path contact_path
    end.to change(Contact, :count).by(1)
  end
end
