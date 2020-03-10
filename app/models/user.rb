class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_update :check_badges


  private

  def check_badges
    # TODO write this code.. happens after the driver gives thumbs up or down
  end
end
