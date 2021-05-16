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
                       allow_nil: true
  attr_accessor :current_password

  # 渡された文字列のハッシュ値を返す
  # def self.digest(string)
  #   cost = if ActiveModel::SecurePassword.min_cost
  #            BCrypt::Engine::MIN_COST
  #          else
  #            BCrypt::Engine.cost
  #          end
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # ランダムなトークンを返す
  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # 永続セッションのためにユーザーをデータベースに記憶する
  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # def authenticated?(attribute, token)
  #   digest = send("#{attribute}_digest")
  #   return false if digest.nil?

  #   BCrypt::Password.new(digest).is_password?(token)
  # end

  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  # def active
  #   update_columns(activated: true, activated_at: Time.zone.now)
  # end

  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end

  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  # def create_activation_digest
  #   self.activation_token  = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end
end
