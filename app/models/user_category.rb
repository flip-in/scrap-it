class UserCategory < ApplicationRecord
  belongs_to :category
  belongs_to :user
  # validates_length_of :categories_ids, :minimum => 5, :message => "blah blah blah"

  # private 
  #   def user_category_limit
  #     @categories_array = params[:categories_ids]
  #     if categories_array < 2
  #       errors.add(:categories_array, "cannot be above 400 cubic inches")
  #     end
  #   end

    # def validate_wdays
    #   if !categories_array.is_a?(Array) || categories_array.detect{|d| !(0..6).include?(d)}
    #     errors.add(:categories_array, :invalid)
    #   end

end
