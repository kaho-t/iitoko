module SessionsHelper
  def log_in_as_user_with_remembering(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    check 'user[remember_me]'
    click_button 'ログイン'
  end

  def log_in_as_user(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  def log_in_as_local(local)
    visit new_local_session_path
    fill_in 'local[email]', with: local.email
    fill_in 'local[password]', with: local.password
    click_button 'ログイン'
  end
end
