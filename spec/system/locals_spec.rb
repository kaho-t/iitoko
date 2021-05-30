RSpec.describe 'Locals', js: true, type: :system do
let(:local) { FactoryBot.build(:local) }

  describe 'creating a new local' do
    before do
      @number_of_locals = Local.count
      ActionMailer::Base.deliveries.clear
    end

    context 'when tried to create a new local with invalid info' do
      it 'fails to create without a name' do
        visit root_path
        click_link '自治体の方はこちら'
        expect(page).to have_content '自治体としてログイン'
        click_link '自治体登録'
        expect(page).to have_content '自治体登録'
        fill_in '自治体名', with: ""
        fill_in 'メールアドレス', with: local.email
        fill_in 'パスワード', with: local.password
        fill_in 'パスワード（確認用）', with: local.password_confirmation
        click_button '自治体登録'

        expect(Local.count).to eq @number_of_locals
        expect(page).to have_current_path '/locals'
        expect(page).to have_content 'Nameを入力してください'
        expect(page).to have_css 'div#error_explanation'
      end
      it 'fails to create with unmatch passwords' do
        visit new_local_registration_path
        fill_in '自治体名', with: local.name
        fill_in 'メールアドレス', with: local.email
        fill_in 'パスワード', with: local.password
        fill_in 'パスワード（確認用）', with: 'invalid'
        click_button '自治体登録'
        expect(Local.count).to eq @number_of_locals
        expect(page).to have_current_path '/locals'
        expect(page).to have_css 'div#error_explanation'
      end
    end
    it 'creates a new local' do
      visit new_local_registration_path
      fill_in '自治体名', with: local.name
      fill_in 'メールアドレス', with: local.email
      fill_in 'パスワード', with: local.password
      fill_in 'パスワード（確認用）', with: local.password_confirmation

      expect { click_button '自治体登録' }.to change { ActionMailer::Base.deliveries.size }.by(1)
      # 画面上に「送信成功」のメッセージが表示されていることを検証する
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      expect(local.confirmed_at).to be_nil

      local = Local.last
      token = local.confirmation_token
      visit local_confirmation_path(confirmation_token: token)
      expect(page).to have_content 'メールアドレスが確認できました。'

      local.reload
      expect(local.confirmed_at).to_not be_nil
      expect(page).to have_current_path welcome_path
      expect(page).to have_content 'ようこそ！'

      expect(Local.count).to eq @number_of_locals + 1
    end
    it 'fails to login before activated' do
      visit new_local_registration_path
      fill_in '自治体名', with: local.name
      fill_in 'メールアドレス', with: local.email
      fill_in 'パスワード', with: local.password
      fill_in 'パスワード（確認用）', with: local.password_confirmation
      click_button '自治体登録'

      # 有効化せずにログイン
      log_in_as_local(local)
      expect(page).to have_current_path new_local_session_path
    end
    it 'fails to activate with invalid token' do
      visit new_local_registration_path
      fill_in '自治体名', with: local.name
      fill_in 'メールアドレス', with: local.email
      fill_in 'パスワード', with: local.password
      fill_in 'パスワード（確認用）', with: local.password_confirmation
      click_button '自治体登録'
      # トークンが不正
      visit local_confirmation_path(confirmation_token: 'invalid')
      expect(page).to have_content 'Confirmation tokenは不正な値です'
    end
  end

  describe 'editting a local' do
    context 'updateing a local' do
      it 'fails to update with invalid info' do
        local.save
        local.confirm
        log_in_as_local(local)
        visit edit_local_registration_path
        fill_in '自治体名', with: ''
        fill_in 'メールアドレス', with: local.email
        fill_in 'パスワード', with: local.password
        fill_in 'パスワード（確認用）', with: local.password_confirmation
        click_button '確定する'
        expect(page).to have_content 'アカウント情報編集'
        expect(page).to have_content 'Nameを入力してください'
        expect(page).to have_css 'div#error_explanation'
      end
      it 'updates local info' do
        local.save
        local.confirm
        log_in_as_local(local)
        visit edit_local_registration_path
        # expect(page).to have_current_path new_local_session_path
        # log_in_as_local(local)
        expect(page).to have_current_path edit_local_registration_path
        expect(local.name).to eq '東京都北区'
        fill_in '自治体名', with: '北区'
        fill_in 'メールアドレス', with: local.email
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認用）', with: ''
        fill_in '現在のパスワード', with: local.password
        click_button '確定する'

        expect(page).to have_current_path local_path(local)
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(local.reload.name).to eq '北区'
      end
    end
  end

  describe 'delete a local' do
    it 'deletes a local' do
      local.save
      local.confirm
      @number_of_locals = Local.count
      log_in_as_local(local)
      visit edit_local_registration_path
      page.accept_confirm do
        click_button '退会する'
      end
      expect(page).to have_current_path root_path
      expect(Local.count).to eq @number_of_locals - 1
    end
  end
end