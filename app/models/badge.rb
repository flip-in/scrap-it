class Badge < ApplicationRecord
    validates :name, :decription, :points, presence: true
end
