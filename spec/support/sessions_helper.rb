module SessionsHelper
  def log_in_as_user_with_remembering(user)
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    check 'session[remember_me]'
    click_button 'ログイン'
  end

  def log_in_as_user(user)
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
  end
end
