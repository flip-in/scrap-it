class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.integer :point_cost
      t.string :redeem_code
      t.integer :amount
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
