class Score < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :local, optional: true
  attribute :nature, :integer, default: 0
  attribute :accessibility, :integer, default: 0
  attribute :budget, :integer, default: 0
  attribute :job_support, :integer, default: 0
  attribute :family_support, :integer, default: 0
  attribute :culture, :integer, default: 0

  validates :nature, presence: true,
                     numericality: { only_integer: true,
                                     greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 5 }
  validates :accessibility, presence: true,
                            numericality: { only_integer: true,
                                            greater_than_or_equal_to: 0,
                                            less_than_or_equal_to: 5 }
  validates :budget, presence: true,
                     numericality: { only_integer: true,
                                     greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 5 }
  validates :job_support, presence: true,
                          numericality: { only_integer: true,
                                          greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 5 }
  validates :family_support, presence: true,
                             numericality: { only_integer: true,
                                             greater_than_or_equal_to: 0,
                                             less_than_or_equal_to: 5 }
  validates :culture, presence: true,
                      numericality: { only_integer: true,
                                      greater_than_or_equal_to: 0,
                                      less_than_or_equal_to: 5 }
end
