class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :driver, optional: true
  validates :date, :time_of_day, presence: true, on: :create
  before_save :assign_driver

  def assign_driver
    self.driver = Driver.first
  end
end
