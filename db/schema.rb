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

ActiveRecord::Schema.define(version: 20170911065656) do

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "campaign_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", default: 0, null: false
    t.string "email", null: false, collation: "utf8_unicode_ci"
    t.string "first_name", collation: "utf8_unicode_ci"
    t.string "last_name", collation: "utf8_unicode_ci"
    t.string "phone", collation: "utf8_unicode_ci"
    t.string "fax", collation: "utf8_unicode_ci"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "domain_name"
  end

  create_table "list_subscriptions", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", default: 0, null: false
    t.integer "list_id", null: false
    t.integer "contact_id", null: false
    t.boolean "active", default: true
    t.integer "status", limit: 2, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "list_type"
    t.integer "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
