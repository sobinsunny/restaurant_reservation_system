class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string  :email, null: false
      t.string  :name, null: false
      t.timestamps
    end
  end
end
