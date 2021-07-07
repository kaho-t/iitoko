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
  attr_accessor :current_password
  has_one :score, dependent: :destroy

  has_one :profile, dependent: :destroy

  has_one :tag, dependent: :destroy

  has_many :articles, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  has_many :talkrooms, dependent: :destroy
  has_many :talking_withs, through: :talkrooms, source: :user

  has_many :messages

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'notice_from', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'notice_to', dependent: :destroy

  has_many :active_footprints, class_name: 'Footprint', foreign_key: 'visitorlocal_id', dependent: :destroy
  has_many :visitedusers, through: :active_footprints

  has_many :passive_footprints, class_name: 'Footprint', foreign_key: 'visitedlocal_id', dependent: :destroy
  has_many :visitorusers, through: :passive_footprints

  ransack_alias :local_tags, :tag_sea_or_tag_mountain_or_tag_river_or_tag_field_or_tag_hotspring_or_tag_north_or_tag_south_or_tag_easy_to_tag_go_or_tag_small_city_or_tag_car_or_tag_train_or_tag_low_price_or_tag_moving_support_or_tag_entrepreneur_support_or_tag_child_care_support_or_tag_job_change_support_or_tag_park_or_tag_education_or_tag_food_or_tag_architecture_or_tag_history_or_tag_event_or_tag_tourism

  attr_accessor :match_rate

  def visit(user)
    unless active_footprints.where(visiteduser_id: user.id, created_at: Time.now.all_day).any?
      visitedusers << user
    else
      footprint = active_footprints.find_by(visiteduser_id: user.id, created_at: Time.now.all_day)
      footprint.update(updated_at: Time.now)
    end
  end

  def visited?(user)
    visitedusers.include?(user)
  end

end
