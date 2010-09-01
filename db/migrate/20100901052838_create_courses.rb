class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses, :force => true do |t|
      t.string :title
      t.string :code
      t.integer :user_id
      t.date :begins_on
      t.date :ends_on
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
