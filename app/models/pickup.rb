class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :driver, optional: true
  validates :date, :time_of_day, presence: true, on: :create
  validates :status, inclusion: {in: ['pending', 'complete', 'confirmed']}
  validates :feedback, presence: true, on: :feedback
  before_save :assign_driver

  
  def assign_driver
    self.driver = Driver.first
  end
end
