require 'faker'
require 'open-uri'

puts 'Cleaning database'
UserBadge.destroy_all
Badge.destroy_all
Pickup.destroy_all
Driver.destroy_all
UserReward.destroy_all
Reward.destroy_all
UserCategory.destroy_all
Category.destroy_all
User.destroy_all

puts 'Creating test user and driver...'

User.create!(
  email: "sgood@test.com",
  password: "password",
  user_name: "test123",
  address: "18 Avenue C New York, NY 10009 USA",
  phone_number: Faker::PhoneNumber.cell_phone,
  first_name: "Sherwood",
  last_name: "Goode",
  latitude: 40.721223,
  longitude: -73.980769,
  points: 275,
  lifetime_points: 375,
  )

Driver.create!(
  email: "test@test.com",
  password: "password",
  first_name: "Perry",
  last_name: "Nunes",
  )

puts 'Creating categories and badges...'

category_arr = ["Theater", "Museums", "Food", "Music", "Sports", "Events"]
category_arr.each { |cat| Category.create!( name: cat ) }

#create! 6 badges: 1st pickup, 10 pickup, 20 pickup 25kg, 50kg, 100kg
badges = [
  {
  name: "1st_pickup",
  description: "1st pickup badge!",
  points: 100
  },
  {
  name: "10th_pickup",
  description: "10th pickup badge!",
  points: 100+10*25
  },
  {
  name: "20th_pickup",
  description: "20th pickup badge!",
  points: 100+20*25
  },
  {
  name: "100th_pickup",
  description: "100th pickup badge!",
  points: 100+100*25
  },
  {
  name: "25kg",
  description: "25kg composted!",
  points: 100+((25/2)*25)
  },
  {
  name: "50kg",
  description: "50kg composted!",
  points: 100+((25/2)*50)
  },
  {
  name: "100kg",
  description: "100kg composted!",
  points: 100+((25/2)*100)
  }
]

Badge.create!(badges)
# create! 1-3 rewards in NYC for each category
puts "Creating Rewards..."

rewards = [
  {
  name: "Two free New York Yankees Tickets",
  description: "Use the code provided at nyyankees.com to redeem your tickets",
  point_cost: 400,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 30,
  category: Category.find_by_name("Sports")
  },
  {
  name: "Two free New York Knicks Tickets",
  description: "Use the code provided at nyknicks.com to redeem your tickets",
  point_cost: 400,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 50,
  category: Category.find_by_name("Sports")
  },
  {
  name: "15% off Hamilton Tickets",
  description: "Use the code provided at the ticket counter to redeem your discount",
  point_cost: 750,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 10,
  category: Category.find_by_name("Theater")
  },
  {
  name: "50% off MOMA Tickets",
  description: "Use the code provided at the museum's ticketing counter to redeem your discount",
  point_cost: 200,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 100,
  category: Category.find_by_name("Museums")
  },
  {
  name: "50% off Museum of the City of New York",
  description: "Use the code provided at the museum's ticketing counter to redeem your discount",
  point_cost: 200,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 30,
  category: Category.find_by_name("Museums")
  },
  {
  name: "10% off the next concert of your choice",
  description: "Use the code provided on https://ticketmaster.com to redeem your discount when checking out",
  point_cost: 200,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 30,
  category: Category.find_by_name("Music")
  },
  {
  name: "50% off the next concert of your choice",
  description: "Use the code provided on https://ticketmaster.com to redeem your discount when checking out",
  point_cost: 600,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 30,
  category: Category.find_by_name("Music")
  },
  {
  name: "One free appetizer at Boucherie Union Square",
  description: "Show your server or the manager the code provided before you order",
  point_cost: 100,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 30,
  category: Category.find_by_name("Food")
  },
  {
  name: "One free slice at Lombardi's Pizza",
  description: "Show your server or the manager the code provided before you order",
  point_cost: 75,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 30,
  category: Category.find_by_name("Food")
  },
  {
  name: "One free entry to New York Food Festival",
  description: "Use the code provided when you reach the venue ticketing area",
  point_cost: 100,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 100,
  category: Category.find_by_name("Events")
  },
  {
  name: "One 1-day pass for Governors Ball",
  description: "Use the code provided when you purchase your ticket online at https://governorsball.frontgatetickets.com/",
  point_cost: 800,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 10,
  category: Category.find_by_name("Events")
  },
  {
  name: "One free entry to Brooklyn Beerfest",
  description: "Use the code provided when you reach the venue ticketing area",
  point_cost: 100,
  redeem_code: Faker::Internet.password(min_length: 6, max_length: 8),
  amount: 200,
  category: Category.find_by_name("Events")
  }
]

Reward.create!(rewards)

puts "Seeding pickups..."

feedback_arr = ["Non-compostable items in bin", "Didn’t use a compostable bag", "Bin was not easy to find"]
time_of_day_arr = ["Morning (7AM - 11AM)", "Afternoon (11AM - 4PM)", "Evening (4PM - 8PM)"]
status_arr = ["Pending", "Confirmed", "Completed"]
#1 coming up
#1 today
# 4 in the past as good
# 2 in the past as bad
pickups = [
  {
  status: "complete",
  date: Date.today - 20,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 24,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 26,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 28,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 32,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 36,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 38,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 5,
  time_of_day: time_of_day_arr.sample,
  notes: "There might be some maintenance going on in the basement today.",
  rating: false,
  feedback: feedback_arr.sample(2),
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 2,
  time_of_day: time_of_day_arr.sample,
  notes: "Look out for the green door! You might have to push hard",
  rating: false,
  feedback: feedback_arr.sample(1),
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 10,
  time_of_day: time_of_day_arr.sample,
  rating: true,
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "complete",
  date: Date.today - 14,
  time_of_day: time_of_day_arr.sample,
  rating: false,
  feedback: feedback_arr.sample(3),
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "pending",
  date: Date.today + 3,
  time_of_day: time_of_day_arr.sample,
  notes: "Look out for the green door! You might have to push hard",
  user_id: User.first.id,
  driver_id: Driver.first.id
  },
  {
  status: "pending",
  date: Date.today + 10,
  time_of_day: time_of_day_arr.sample,
  notes: "Look out for the green door! You might have to push hard",
  user_id: User.first.id,
  driver_id: Driver.first.id
  }
  # {
  # status: "confirmed",
  # date: Date.today,
  # time_of_day: time_of_day_arr.sample,
  # user_id: User.first.id,
  # driver_id: Driver.first.id
  # }
]

Pickup.create!(pickups)

puts "Seeding user categories..."

UserCategory.create!( category_id: Category.find_by_name("Events").id, user_id: User.first.id)

UserCategory.create!( category_id: Category.find_by_name("Museums").id, user_id: User.first.id)

UserCategory.create!( category_id: Category.find_by_name("Food").id, user_id: User.first.id)

puts "Seeding user rewards..."

UserReward.create!(reward_id: Reward.find_by_name("Two free New York Knicks Tickets").id, user_id: User.first.id )

UserReward.create!(reward_id: Reward.find_by_name("One 1-day pass for Governors Ball").id, user_id: User.first.id )

UserReward.create!(reward_id: Reward.find_by_name("15% off Hamilton Tickets").id, user_id: User.first.id )

Badge.where('points <= ?', User.first.lifetime_points).each do |badge|
 UserBadge.create!(user: User.first, badge: badge)
end


