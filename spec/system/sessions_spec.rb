require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    user.confirm
    user.reload
  end

  describe 'log in' do
    context 'when log in with a valid user info' do
      it 'shows view for logged in user' do
        log_in_as_user(user)
        expect(page).to have_current_path '/top'
        expect(page).to have_css 'li.dropdown'
        expect(page).to have_content 'ログインしました。'
      end
      it 'redirects to recommends page from login and signup page' do
        log_in_as_user(user)
        visit new_user_session_path
        expect(page).to have_current_path '/top'
        visit new_user_registration_path
        expect(page).to have_current_path '/top'
      end
      it 'does not have cookies' do
        log_in_as_user(user)
        expect(get_me_the_cookie('remember_token')).to eq nil
      end
    end

    context 'when tries to log in with invalid user info' do
      it 'denies to login' do
        visit new_user_session_path
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_current_path '/users/sign_in'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        visit root_path
        expect(page).to_not have_content 'メールアドレスまたはパスワードが違います。'
        expect(page).to_not have_content 'li.dropdown'
      end
    end
  end

  describe 'logout' do
    it 'logs out' do
      log_in_as_user_with_remembering(user)
      click_link 'ログアウト'
      expect(page).to have_current_path '/'
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  # describe 'remember_me' do
  #   it 'remembers user login when login with remembering' do
  #     log_in_as_user_with_remembering(user)
  #     expect(page).to have_content 'ログインしました。'
  #     expect(user.remember_created_at).to_not nil
  #   end
  #   it 'does not remember user login when login without remembering' do
  #     log_in_as_user(user)
  #     expect(page).to have_content 'ログインしました。'
  #     expect(user.remember_created_at).to nil
  #   end
  # end
end
