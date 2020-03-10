class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :driver
  validates :date, :time_of_day, presence: true
end
