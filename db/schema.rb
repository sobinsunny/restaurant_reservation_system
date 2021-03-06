# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_125_122_518) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'guests', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reservations', force: :cascade do |t|
    t.bigint 'guest_id', null: false
    t.bigint 'table_id', null: false
    t.integer 'guest_party_size'
    t.datetime 'requested_date_time', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['guest_id'], name: 'index_reservations_on_guest_id'
    t.index ['table_id'], name: 'index_reservations_on_table_id'
  end

  create_table 'restaurants', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'phone_number', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'tables', force: :cascade do |t|
    t.integer 'number', null: false
    t.integer 'number_of_seats', default: 1
    t.bigint 'restaurant_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['restaurant_id'], name: 'index_tables_on_restaurant_id'
  end

  add_foreign_key 'reservations', 'guests'
  add_foreign_key 'reservations', 'tables'
end
