class Category < ApplicationRecord
    has_many :rewards
    validates :name, presence: true
end
