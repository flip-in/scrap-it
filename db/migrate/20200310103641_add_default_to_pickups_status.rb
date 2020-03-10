class AddDefaultToPickupsStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :pickups, :status, :string, default: 'pending'
  end
end
