class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :post_id
      t.text :body

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
