class Footprint < ApplicationRecord
  belongs_to :visitoruser, class_name: 'User', optional: true
  belongs_to :visiteduser, class_name: 'User', optional: true
  belongs_to :visitorlocal, class_name: 'Local', optional: true
  belongs_to :visitedlocal, class_name: 'Local', optional: true

  def create_notification_visited(current_account, visited_account)
    if current_account.class == User and visited_account.class == Local
      notice = Notification.where(["notice_from = ? and is_from_user = ? and notice_to = ? and is_for_user = ? and footprint_id = ? and action = ?", current_account.id, true, visited_account.id, false, id, 'footprint'])
      if notice.blank?
        notification = current_account.active_notifications.new(
          footprint_id: id,
          is_from_user: true,
          notice_to: visited_account.id,
          is_for_user: false,
          action: 'footprint'
        )
        notification.save if notification.valid?
      end
    elsif current_account.class == Local and visited_account.class == User
      notice = Notification.where(["notice_from = ? and is_from_user = ? and notice_to = ? and is_for_user = ? and footprint_id = ? and action = ?", current_account.id, false, visited_account.id, true, id, 'footprint'])
      if notice.blank?
        notification = current_account.active_notifications.new(
          footprint_id: id,
          is_from_user: false,
          notice_to: visited_account.id,
          is_for_user: true,
          action: 'footprint'
        )
        notification.save if notification.valid?
      end
    else
      return
    end
  end
end
