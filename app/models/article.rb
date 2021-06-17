class Article < ApplicationRecord
  has_rich_text :content
  has_one_attached :main_image
  belongs_to :local
  has_one :tag, dependent: :destroy
  accepts_nested_attributes_for :tag, allow_destroy: true
  default_scope -> { order(created_at: :desc)}
  validates :title, presence: true, length: { maximum: 255 }
  validate :content_required
  validate :main_image_content_type, if: :was_attached?
  validates :main_image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "はpng/jpg/jpeg/gifのいずれかにしてください" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB以下にしてください" }

  private
  def content_required
    errors.add(:content, "を入力してください") unless content.body.present?
  end

  def main_image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']
    errors.add(:main_image, "はpng/jpg/jpeg/gifのいずれかにしてください") unless main_image.content_type.in?(extension)
  end

  def was_attached?
    self.main_image.attached?
  end

end
