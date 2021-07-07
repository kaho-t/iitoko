class UserProfile < ApplicationRecord
  belongs_to :user

  include JpPrefecture
  jp_prefecture :prefecture_code

  validates :prefecture_code, numericality: {
                                only_integer: true,
                                greater_than_or_equal_to: 1,
                                less_than_or_equal_to: 47 },
                              allow_nil: true
  validates :age, numericality: {
                                  only_integer: true,
                                  greater_than_or_equal_to: 1,
                                  less_than_or_equal_to: 99 },
                  allow_nil: true
  validates :proposed_site, length: { maximum: 50 }, allow_nil: true
  validates :job, length: { maximum: 50 }, allow_nil: true
  validates :family_structure, length: { maximum: 50 }, allow_nil: true
  validates :timing, length: { maximum: 50 }, allow_nil: true
  validates :content, length: { maximum: 255 }, allow_nil: true

end
