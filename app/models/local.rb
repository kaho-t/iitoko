class Local < ApplicationRecord
  mount_uploader :image, ImageUploader
  include JpPrefecture
  jp_prefecture :prefecture_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :lockable

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{8,12}\z/
  validates :password, presence: true,
                       format: { with: VALID_PASSWORD_REGEX,
                                 message: 'は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります' },
                       allow_nil: true,
                       confirmation: true
  validates :password_confirmation, presence: true, allow_nil: true
  attr_accessor :current_password, :match_rate

  has_one :score, dependent: :destroy

  has_one :profile, dependent: :destroy

  has_one :tag, dependent: :destroy

  has_many :articles, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  has_many :talkrooms, dependent: :destroy
  has_many :talking_withs, through: :talkrooms, source: :user

  has_many :messages, as: :sender, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'notice_from', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'notice_to', dependent: :destroy

  has_many :active_footprints, class_name: 'Footprint', foreign_key: 'visitorlocal_id', inverse_of: :visitorlocal,
                               dependent: :destroy
  has_many :visitedusers, through: :active_footprints, inverse_of: :visitorlocals

  has_many :passive_footprints, class_name: 'Footprint', foreign_key: 'visitedlocal_id', inverse_of: :visitedlocal,
                                dependent: :destroy
  has_many :visitorusers, through: :passive_footprints, inverse_of: :visitedlocals

  def visit(user)
    if active_footprints.where(visiteduser_id: user.id, created_at: Time.zone.now.all_day).any?
      footprint = active_footprints.find_by(visiteduser_id: user.id, created_at: Time.zone.now.all_day)
      footprint.update(updated_at: Time.zone.now)
    else
      visitedusers << user
    end
  end

  def visited?(user)
    visitedusers.include?(user)
  end

  def full_name
    "#{prefecture.name} #{name}"
  end
end
