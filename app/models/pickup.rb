class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :driver
  validates :date, presence: true
end
