ActiveRecord::Schema.define(:version => 20120611163936) do
  create_table "test", :force => true do |t|
    t.integer "cached_column"
    t.boolean "boolean"
  end
end
