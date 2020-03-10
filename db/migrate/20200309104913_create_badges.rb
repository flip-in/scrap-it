class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.integer :points

      t.timestamps
    end
  end
end
