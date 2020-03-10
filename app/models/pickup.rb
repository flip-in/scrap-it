class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :driver
  validates :date, :time_of_day, presence: true, on: :create
  validate :validate_review, on: :update

  # def validate_review 
  # if 
  # end

end
