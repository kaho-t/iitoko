class UserProfile < ApplicationRecord
  belongs_to :user

  include JpPrefecture
  jp_prefecture :prefecture_code

  validates :prefecture_code, presence: true, inclusion: { in: (1..47).to_a}
  validates :age, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 99
  }
  validates :job, presence: true, length: { maximum: 50 }
  validates :family_structure, presence: true, length: { maximum: 50 }
  validates :timing, presence: true, length: { maximum: 50 }
  validates :proposed_site, length: { maximum: 50 }, allow_nil: true
  validates :content, length: { maximum: 255 }, allow_nil: true
end
