class Badge < ApplicationRecord
    validates :name, :description, :points, presence: true
    validates :points, numericality: true
    validates :name, uniqueness: true
end
