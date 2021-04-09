require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'log in' do
    context 'when log in with a valid user info' do
      before do
        visit login_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_button 'ログイン'
      end
      it 'shows view for logged in user' do
        expect(page).to have_current_path '/'
        expect(page).to have_css 'li.dropdown'
        expect(page).to_not have_content 'ログイン'
      end
      it 'redirects to recommends page from login and signup page' do
        visit login_path
        expect(page).to have_current_path '/'
        visit signup_path
        expect(page).to have_current_path '/'
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

  describe 'log out' do
    it 'logs out' do
      visit login_path
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: @user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログアウト'
      click_link 'ログアウト'
      expect(page).to have_current_path '/'
      expect(page).to have_content 'ログイン'
      expect(page).to_not have_content 'ログアウト'
    end
  end
end
