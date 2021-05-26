class Score < ApplicationRecord
  belongs_to :user
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
