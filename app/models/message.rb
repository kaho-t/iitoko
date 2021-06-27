class Message < ApplicationRecord
  belongs_to :talkroom
  belongs_to :local, optional: true
  belongs_to :user, optional: true
  has_many_attached :photos
  has_many_attached :pdfs
  has_many :notifications, dependent: :destroy

  validates :category, presence: true, length: { maximum: 50}
  validates :photos, content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "はpng/jpg/jpeg/gifのいずれかにしてください" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB以下にしてください" }
  validates :pdfs, content_type: { in: 'application/pdf', message: 'はpdfにしてください' },
                    size: { less_than: 5.megabytes, message: 'は5MB以下にしてください'}


  def create_notification_msg(current_account, msg)
    if current_account == msg.talkroom.user
      msg_n = Notification.where("notice_from = ? and is_from_user = ? and message_id = ? and action = ?", current_account.id, true, id, 'message')
      if msg_n.blank?
        notification = current_account.active_notifications.new(
          message_id: id,
          is_from_user: true,
          notice_to: msg.talkroom.local.id,
          is_for_user: false,
          action: 'message'
        )
        notification.save if notification.valid?
      end
    elsif current_account == msg.talkroom.local
      msg_n = Notification.where("notice_from = ? and is_from_user = ? and message_id = ? and action = ?", current_account.id, false, id, 'message')
      if msg_n.blank?
        notification = current_account.active_notifications.new(
          message_id: id,
          is_from_user: false,
          notice_to: msg.talkroom.user.id,
          is_for_user: true,
          action: 'message'
        )
        notification.save if notification.valid?
      end
    end
  end

end
