ActiveRecord::Schema.define(:version => 20090217091952) do

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.boolean  "official",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_type",    :default => "PUBLIC"
    t.integer  "comments_count", :default => 0
  end

end
