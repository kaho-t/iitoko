class Message < ApplicationRecord
  belongs_to :talkroom
  belongs_to :local, optional: true
  belongs_to :user, optional: true
  has_many_attached :photos
  has_many_attached :pdfs

  validates :category, presence: true, length: { maximum: 50}
  validates :photos, content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "はpng/jpg/jpeg/gifのいずれかにしてください" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB以下にしてください" }
  validates :pdfs, content_type: { in: 'application/pdf', message: 'はpdfにしてください' },
                    size: { less_than: 5.megabytes, message: 'は5MB以下にしてください'}
end
