ActiveRecord::Schema.define(:version => 20090217091952) do

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
