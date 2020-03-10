class Reward < ApplicationRecord
  belongs_to :category
  validates :name, :description, :point_cost, :redeem_code, :amount, presence: true 
  validates :name, :redeem_code, uniqueness: true
  validates :point_cost, :amount, numericality: true
  # validates :redeem_code, length: { is: 6 }
end
 