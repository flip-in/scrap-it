class Badge < ApplicationRecord
    validates :name, :decription, :points, presence: true
    validates :points, numericality: true
    validates :name, uniqueness: true
end
