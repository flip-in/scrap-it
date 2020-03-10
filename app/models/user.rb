class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_badges
  has_many :user_rewards
  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :badges, through: :user_badges
  has_many :rewards, through: :user_rewards
  after_update :check_badges


  private

  def check_badges
    # TODO write this code.. happens after the driver gives thumbs up or down
  end
end

