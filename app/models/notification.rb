class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :bookmark, optional: true
  belongs_to :talkroom, optional: true
  belongs_to :message, optional: true
  belongs_to :article, optional: true

  belongs_to :user, optional: true
  belongs_to :local, optional: true
end
