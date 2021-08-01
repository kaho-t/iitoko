class UserProfile < ApplicationRecord
  belongs_to :user

  include JpPrefecture
  jp_prefecture :prefecture_code

  validates :prefecture_code, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 47
  },
                              allow_nil: true
  validates :age, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 99
  },
                  allow_nil: true
  validates :proposed_site, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :job, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :family_structure, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :timing, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :content, presence: true, length: { maximum: 255 }, allow_nil: true
end
