class Talkroom < ApplicationRecord
  belongs_to :user
  belongs_to :local
  has_many :messages, dependent: :destroy
end
