require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'log in' do
    context 'when log in with a valid user info' do
      it 'shows view for logged in user' do
        log_in_as_user
        expect(page).to have_current_path '/'
        expect(page).to have_css 'li.dropdown'
        expect(page).to_not have_content 'ログイン'
      end
      it 'redirects to recommends page from login and signup page' do
        log_in_as_user
        visit login_path
        expect(page).to have_current_path '/'
        visit signup_path
        expect(page).to have_current_path '/'
      end
      it 'does not have cookies' do
        log_in_as_user
        expect(get_me_the_cookie('remember_token')).to eq nil
      end
    end

    context 'when tries to log in with invalid user info' do
      it 'denies to log' do
        visit login_path
        fill_in 'session[email]', with: ''
        fill_in 'session[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_current_path '/login'
        expect(page).to have_content 'メールアドレスまたはパスワードが間違っています'
        visit root_path
        expect(page).to_not have_content 'メールアドレスまたはパスワードが間違っています'
        expect(page).to_not have_content 'li.dropdown'
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'logout' do
    it 'logs out' do
      log_in_as_user_with_remembering
      expect(get_me_the_cookie('remember_token')).to_not eq nil
      expect(page).to have_content 'ログアウト'
      click_link 'ログアウト'
      expect(page).to have_current_path '/'
      expect(page).to have_content 'ログイン'
      expect(page).to_not have_content 'ログアウト'
      expire_cookies
      expect(get_me_the_cookie('remember_token')).to eq nil
    end
  end

  describe 'across browser restarts' do
    it 'remembers user login when login with remembering' do
      log_in_as_user_with_remembering
      expect(get_me_the_cookie('remember_token')).to_not eq nil
      # browser restart = session cookie is lost
      expire_cookies
      expect(get_me_the_cookie('remember_token')).to_not eq nil
    end
    it 'does not remember user login when login without remembering' do
      log_in_as_user
      expect(get_me_the_cookie('remember_token')).to eq nil
    end
  end

end
