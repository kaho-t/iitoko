require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User CRUD' do
    before do
      @user = FactoryBot.build(:user)
      @number_of_users = User.count
    end

    context 'creating a new user' do
      it 'fails to create a user' do
        visit signup_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        fill_in 'パスワード（確認）', with: @user.password_confirmation
        click_button 'ユーザー登録'

        expect(User.count).to eq @number_of_users
        expect(page).to have_current_path '/users'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_css 'div#error_explanation'
      end
      it 'creates a new user' do
        visit signup_path
        fill_in '名前', with: @user.name
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        fill_in 'パスワード（確認）', with: @user.password_confirmation
        click_button 'ユーザー登録'

        @user = User.find_by(email: @user.email)

        expect(User.count).to eq @number_of_users + 1
        expect(page).to have_current_path "/users/#{@user.id}/edit"
        expect(page).to have_content 'ようこそ！'
        expect(page).to have_content @user.name
      end
    end
  end
end
