require 'rails_helper'

RSpec.describe 'Users', js: true, type: :system do
  describe 'User CRUD' do
    let(:user) { FactoryBot.build(:user) }
    let(:another_user) { FactoryBot.create(:user, email: 'another@example.com') }
    let(:score) { FactoryBot.create(:score)}
    before do
      @number_of_users = User.count
      ActionMailer::Base.deliveries.clear
    end

    context 'creating a new user' do
      it 'fails to create a user without a name' do
        visit new_user_registration_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認）', with: user.password_confirmation
        click_button 'ユーザー登録'

        expect(User.count).to eq @number_of_users
        expect(page).to have_current_path '/users'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_css 'div#error_explanation'
      end
      it 'creates a new user' do
        visit new_user_registration_path
        fill_in '名前', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認）', with: user.password_confirmation

        expect { click_button 'ユーザー登録' }.to change { ActionMailer::Base.deliveries.size }.by(1)
        # 画面上に「送信成功」のメッセージが表示されていることを検証する
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        expect(user.confirmed_at).to be_nil

        user = User.last
        token = user.confirmation_token
        visit user_confirmation_path(confirmation_token: token)
        expect(page).to have_content 'メールアドレスが確認できました。'

        user.reload
        expect(user.confirmed_at).to_not be_nil
        expect(page).to have_current_path welcome_path
        expect(page).to have_content 'ようこそ！'

        expect(User.count).to eq @number_of_users + 1
      end
      it 'fails to login before activated' do
        visit new_user_registration_path
        fill_in '名前', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認）', with: user.password_confirmation
        click_button 'ユーザー登録'

        # 有効化せずにログイン
        log_in_as_user(user)
        expect(page).to have_current_path new_user_session_path
      end
      it 'fails to activate with invalid token' do
        visit new_user_registration_path
        fill_in '名前', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認）', with: user.password_confirmation
        click_button 'ユーザー登録'
        # トークンが不正
        visit user_confirmation_path(confirmation_token: 'invalid')
        expect(page).to have_content 'パスワード確認用トークンは不正な値です'
      end
    end

    context 'updateing a user' do
      it 'fails to update with invalid info' do
        user.save
        user.confirm
        log_in_as_user(user)
        visit edit_user_registration_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認）', with: user.password_confirmation
        click_button '確定する'
        expect(page).to have_content 'アカウント情報編集'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_css 'div#error_explanation'
      end
      it 'updates user info' do
        user.save
        user.confirm
        user.score = score
        visit edit_user_registration_path
        expect(page).to have_current_path new_user_session_path
        log_in_as_user(user)
        expect(page).to have_current_path edit_user_registration_path
        expect(user.name).to eq 'iitoko taro'
        fill_in '名前', with: 'いいとこ　太郎'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認）', with: ''
        fill_in '現在のパスワード', with: user.password
        click_button '確定する'

        expect(page).to have_current_path user_path
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(user.reload.name).to eq 'いいとこ　太郎'
      end
    end

    context 'destroying a user' do
      it 'deletes a user' do
        user.save
        user.confirm
        @number_of_users = User.count
        log_in_as_user(user)
        visit edit_user_registration_path
        page.accept_confirm do
          click_button '退会する'
        end
        expect(page).to have_current_path root_path
        expect(User.count).to eq @number_of_users - 1
      end
    end

  end
end
