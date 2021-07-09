RSpec.describe 'Locals', js: true, type: :system do
  let(:local) { FactoryBot.build(:local) }
  let(:hokkaido) { FactoryBot.build(:local, prefecture_code: 1, name: '札幌') }
  let(:shimokawa) { FactoryBot.build(:local, prefecture_code: 1, name: '下川町') }
  let(:tag) { FactoryBot.build(:tag, local: local) }
  let(:shimokawa_tag) { FactoryBot.build(:tag, local: shimokawa) }

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
        select '北海道', from: '都道府県'
        fill_in '自治体名', with: ''
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
        expect(local.name).to eq '北区'
        fill_in '自治体名', with: '足立区'
        fill_in 'メールアドレス', with: local.email
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認用）', with: ''
        fill_in '現在のパスワード', with: local.password
        click_button '確定する'

        expect(page).to have_current_path local_path(local)
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(local.reload.name).to eq '足立区'
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
  describe 'local uploads an attachment' do
    it 'successfully uploads' do
      local.save
      local.confirm
      sign_in local
      visit edit_local_registration_path
      attach_file 'ヘッダー画像', Rails.root.join('spec/files/attachment.jpeg').to_s
      fill_in '現在のパスワード', with: local.password
      click_button '確定する'
      expect(page).to have_current_path local_path(local)
    end
  end
  describe 'search' do
    it 'searches locals only from prefecture' do
      local.save
      hokkaido.save
      visit search_path
      expect(page).to have_content '札幌'
      select '東京都', from: 'q[prefecture_code_eq]'
      click_button '検索'
      expect(page).to have_content '北区'
      expect(page).to have_no_content '札幌'
    end
    it 'searches locals only from tag' do
      local.save
      hokkaido.save
      tag.save
      visit search_path
      expect(page).to have_content '札幌'
      check 'q[tag_sea_true]'
      click_button '検索'
      expect(page).to have_content '北区'
      expect(page).to have_no_content '札幌'
    end
    it 'searches local from prefecture and tag' do
      local.save
      hokkaido.save
      shimokawa.save
      tag.save
      shimokawa_tag.save
      visit search_path
      expect(page).to have_content '札幌'
      select '北海道', from: 'q[prefecture_code_eq]'
      check 'q[tag_mountain_true]'
      click_button '検索'
      expect(page).to have_content '下川町'
      expect(page).to have_no_content '北区'
      expect(page).to have_no_content '札幌'
    end
  end
end
