class Local < ApplicationRecord
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
end
