class JoinStudentsToCourses < ActiveRecord::Migration
  def self.up
    create_table :courses_users, :force => true, :id => false do |t|
      t.references :course, :user
    end
  end

  def self.down
    drop_table :courses_users
  end
end
