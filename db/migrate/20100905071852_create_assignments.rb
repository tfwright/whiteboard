class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string :name
      t.text :description
      t.datetime :due_at
      t.integer :course_id
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
