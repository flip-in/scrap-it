class UserReward < ApplicationRecord
  belongs_to :reward
  belongs_to :user

  validates :reward, presence: true
end
