class AddDefaultValueToLifetimePointsOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :lifetime_points, :integer, :default => 0
  end
end
