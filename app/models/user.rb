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
  has_many :pickups
  after_update :check_badges
  validates :address, :first_name, :last_name, :phone_number, presence: true, on: :update
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  before_create :generate_code

  def set_qr
    RQRCode::QRCode.new(" https://scrapitapp.herokuapp.com/#{Rails.application.routes.url_helpers.qr_path(id)}")
  end

  def generate_code
    self.qr_token = SecureRandom.hex
  end

  def unavailable_dates
    pickups.pluck(:date)
  end

  def up_next_badges
    user_badges = self.badges
    upcoming_badges = Badge.all - user_badges
    upcoming_badges
  end

  devise :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def check_badges
    # TODO write this code.. happens after the driver gives thumbs up or down
    user_badges = self.badges
    earned_badges = Badge.all.select { |badge| badge.points <= self.lifetime_points}
    badges_to_add = earned_badges - user_badges
    badges_to_add.each do |new_badge|
      UserBadge.create!(user: self, badge: new_badge)
    end
  end
end

