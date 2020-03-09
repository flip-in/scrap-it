class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :qr_token, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :points, :integer
    add_column :users, :lifetime_points, :integer
  end
end
