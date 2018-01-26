class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :guest, index: true, foreign_key: true, null: false
      t.references :table, index: true, foreign_key: true, null: false
      t.integer    :guest_party_size
      t.timestamp :requested_date_time, null: false
      t.timestamps
    end
  end
end
