class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :local
  has_many :notifications, dependent: :destroy

  def create_notification_bmk(current_user)
    bmked = Notification.where(["notice_from = ? and is_from_user = ? and notice_to = ? and is_for_user = ? and bookmark_id = ? and action = ?", current_user.id, true, local_id, false, id, 'bookmark'])
    if bmked.blank?
    notification = current_user.active_notifications.new(
      bookmark_id: id,
      is_from_user: true,
      notice_to: local_id,
      is_for_user: false,
      action: 'bookmark'
    )
    notification.save if notification.valid?
    end
  end

end
