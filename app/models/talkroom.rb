class Talkroom < ApplicationRecord
  belongs_to :user
  belongs_to :local
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def create_notification_tkrm(current_account, tkrm)
    if current_account == tkrm.user
      tkrm_n = Notification.where("notice_from = ? and is_from_user = ? and talkroom_id = ? and action = ?", current_account.id, true, id, 'talkroom')
      if tkrm_n.blank?
        notification = current_account.active_notifications.new(
          talkroom_id: id,
          is_from_user: true,
          notice_to: local_id,
          is_for_user: false,
          action: 'talkroom'
        )
        notification.save if notification.valid?
      end
    elsif current_account == tkrm.local
      tkrm_n = Notification.where("notice_from = ? and is_from_user = ? and talkroom_id = ? and action = ?", current_account.id, false, id, 'talkroom')
      if tkrm_n.blank?
        notification = current_account.active_notifications.new(
          talkroom_id: id,
          is_from_user: false,
          notice_to: user_id,
          is_for_user: true,
          action: 'talkroom'
        )
        notification.save if notification.valid?
      end
    end
  end

end
