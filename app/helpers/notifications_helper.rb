module NotificationsHelper
  def unchecked_notifications
    if user_signed_in?
      current_user.passive_notifications.where(
        'is_for_user = ? and is_from_user = ? and is_checked = ?', true, false, false
      )
    elsif local_signed_in?
      current_local.passive_notifications.where(
        'is_for_user = ? and is_from_user = ? and is_checked = ?', false, true, false
      )
    end
  end
end
