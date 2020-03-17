class AddDefaultValueToRewardsPointCost < ActiveRecord::Migration[5.2]
  def change
    change_column :rewards, :point_cost, :integer, default: 0
  end
end
