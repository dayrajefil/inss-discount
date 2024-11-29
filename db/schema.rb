# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_241_128_212_257) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'zip_code', null: false
    t.string 'street', null: false
    t.string 'number', null: false
    t.string 'complement'
    t.string 'neighborhood', null: false
    t.string 'city', null: false
    t.string 'state', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'proponents', force: :cascade do |t|
    t.string 'name'
    t.date 'birthdate'
    t.string 'phone'
    t.decimal 'salary', precision: 10, scale: 2
    t.bigint 'address_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.decimal 'inss', precision: 10, scale: 2
    t.index ['address_id'], name: 'index_proponents_on_address_id'
  end

  add_foreign_key 'proponents', 'addresses'
end
