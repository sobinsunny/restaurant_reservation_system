class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.integer :number, null: false
      t.integer :number_of_seats, default: 1
      t.belongs_to :restaurant
      t.timestamps null: false
      t.timestamps
    end
  end
end
