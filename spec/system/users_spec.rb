require 'rails_helper'

RSpec.describe 'Users', js: true, type: :system do
  describe 'User CRUD' do
    let(:user) { FactoryBot.build(:user) }
    let(:user_not_activated) { FactoryBot.build(:user, activated: false) }
    let(:another_user) { FactoryBot.create(:user, email: 'another@example.com') }
    before do
      @number_of_users = User.count
      ActionMailer::Base.deliveries.clear
    end

    context 'creating a new user' do
      it 'fails to create a user' do
        visit signup_path
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
        visit signup_path
        fill_in '名前', with: user_not_activated.name
        fill_in 'メールアドレス', with: user_not_activated.email
        fill_in 'パスワード', with: user_not_activated.password
        fill_in 'パスワード（確認）', with: user_not_activated.password_confirmation
        click_button 'ユーザー登録'

        expect(ActionMailer::Base.deliveries.size).to eq 1

        email = ActionMailer::Base.deliveries.last
        body = email.body.encoded
        token = body[/(?<=user_account_activations\/)[^\/]+/]

        user = User.last
        expect(user).to_not be_activated

        visit edit_user_account_activation_path(token, email: user.email)
        user.reload
        expect(user).to be_activated
        expect(page).to have_current_path edit_user_path(user)
        expect(page).to have_content 'ようこそ！'

        expect(User.count).to eq @number_of_users + 1
      end
      it 'fails to login before activated' do
        visit signup_path
        fill_in '名前', with: user_not_activated.name
        fill_in 'メールアドレス', with: user_not_activated.email
        fill_in 'パスワード', with: user_not_activated.password
        fill_in 'パスワード（確認）', with: user_not_activated.password_confirmation
        click_button 'ユーザー登録'

        email = ActionMailer::Base.deliveries.last
        body = email.body.encoded
        token = body[/(?<=user_account_activations\/)[^\/]+/]
        user = User.last
        # 有効化せずにログイン
        log_in_as_user(user)
        expect(page).to have_current_path root_path
      end
      it 'fails to activate with invalid token' do
        visit signup_path
        fill_in '名前', with: user_not_activated.name
        fill_in 'メールアドレス', with: user_not_activated.email
        fill_in 'パスワード', with: user_not_activated.password
        fill_in 'パスワード（確認）', with: user_not_activated.password_confirmation
        click_button 'ユーザー登録'

        email = ActionMailer::Base.deliveries.last
        body = email.body.encoded
        token = body[/(?<=user_account_activations\/)[^\/]+/]
        user = User.last
        # トークンが不正
        visit edit_user_account_activation_path('invalid token', email: user.email)
        expect(page).to have_current_path root_path
      end

      it 'fails to activate with invalid email address' do
        visit signup_path
        fill_in '名前', with: user_not_activated.name
        fill_in 'メールアドレス', with: user_not_activated.email
        fill_in 'パスワード', with: user_not_activated.password
        fill_in 'パスワード（確認）', with: user_not_activated.password_confirmation
        click_button 'ユーザー登録'

        email = ActionMailer::Base.deliveries.last
        body = email.body.encoded
        token = body[/(?<=user_account_activations\/)[^\/]+/]
        user = User.last
        # トークンは正しいがメールアドレスが不正
        visit edit_user_account_activation_path(token, email: 'wrong')
        expect(page).to have_current_path root_path
      end
    end

    context 'updateing a user' do
      it 'fails to update with invalid info' do
        user.save
        log_in_as_user(user)
        visit edit_user_path(user)
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認）', with: user.password_confirmation
        click_button '確定する'
        expect(page).to have_current_path user_path(user)
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_css 'div#error_explanation'
      end
      it 'updates user info' do
        user.save
        visit edit_user_path(user)
        expect(page).to have_current_path login_path
        log_in_as_user(user)
        expect(page).to have_current_path edit_user_path(user)
        expect(user.name).to eq 'iitoko taro'
        fill_in '名前', with: 'いいとこ　太郎'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認）', with: ''
        click_button '確定する'
        expect(page).to have_current_path user_path(user)
        expect(page).to have_content '編集しました'
        expect(user.reload.name).to eq 'いいとこ　太郎'
      end
    end

    context 'destroying a user' do
      it 'deletes a user' do
        user.save
        @number_of_users = User.count
        log_in_as_user(user)
        visit edit_user_path(user)
        page.accept_confirm do
          click_link '退会する'
        end
        expect(page).to have_current_path root_path
        expect(User.count).to eq @number_of_users - 1
      end
    end

    context 'when logged in as wrong user' do
      it 'redirects edit' do
        user.save
        log_in_as_user(another_user)
        visit edit_user_path(user)
        expect(page).to have_current_path root_path
      end
      it 'redirects update' do
        user.save
        log_in_as_user(another_user)
        patch user_path(user)
        expect(page).to have_current_path root_path
      end
      it 'redirects destroy' do
        user.save
        log_in_as_user(another_user)
        @number_of_users = User.count
        delete user_path(user)
        expect(page).to have_current_path root_path
        expect(User.count).to eq @number_of_users
      end
    end
  end
end
