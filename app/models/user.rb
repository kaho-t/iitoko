class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :trackable, :validatable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :timeoutable, :omniauthable, omniauth_providers: %i[google_oauth2]

  before_save   :downcase_email
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{8,12}\z/
  validates :password, presence: true,
                       format: { with: VALID_PASSWORD_REGEX, message: 'は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります' },
                       allow_nil: true,
                       confirmation: true
  validates :password_confirmation, presence: true, allow_nil: true
  attr_accessor :current_password

  has_one :score, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
  has_many :locals, through: :bookmarks

  has_many :talkrooms, dependent: :destroy
  has_many :talking_withs, through: :talkrooms, source: :local

  has_many :messages

  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def bookmark_local(local)
    self.bookmarks.find_or_create_by(local_id: local.id)
  end

  def unbookmark_local(local)
    bookmarked = self.bookmarks.find_by(local_id: local.id)
    bookmarked.destroy if bookmarked
  end

  def bookmarking?(local)
    self.locals.include?(local)
  end

  def feed
    # Article.where(local_id: self.local_ids)
    Article.where("local_id IN (?)", local_ids)
  end



  def talking?(local)
    talking_withs.include?(local)
  end

  private

  def downcase_email
    email.downcase!
  end

end
