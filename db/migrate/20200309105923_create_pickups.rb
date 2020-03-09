class CreatePickups < ActiveRecord::Migration[5.2]
  def change
    create_table :pickups do |t|
      t.string :status
      t.date :date
      t.string :time_of_day
      t.text :notes
      t.boolean :rating
      t.text :feedback
      t.references :user, foreign_key: true
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
