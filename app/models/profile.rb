class Profile < ApplicationRecord
  belongs_to :local
  validates :introduction, length: { maximum: 255 }, allow_nil: true

  validates :population, numericality: { only_integer: true,
                        greater_than_or_equal_to: 0,
                        less_than_or_equal_to: 4999999 }, allow_nil: true

  validates :temperature, numericality: { less_than: 100.0 }, allow_nil: true

  validates :moved_in, numericality: { greater_than_or_equal_to: 0,
                                        less_than: 1000000 }, allow_nil: true

  validates :waiting_children, numericality: { greater_than_or_equal_to: 0,
                                                less_than: 1000 }, allow_nil: true

  validates :land_price, numericality: { greater_than_or_equal_to: 0,
                                          less_than: 10000000 }, allow_nil: true

  validates :income, numericality: { greater_than_or_equal_to: 0,
                                      less_than: 100000000}, allow_nil: true

  validates :crime_rate, numericality: { greater_than_or_equal_to: 0.0,
                                          less_than_or_equal_to: 100.0 }, allow_nil: true
end
