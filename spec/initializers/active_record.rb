ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
    t.string :title

    t.timestamps
  end
end

class Post < ActiveRecord::Base
end
