class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions, :force => true do |t|
      t.integer :assignment_id
      t.integer :student_id
      t.timestamps
      t.string :upload_file_name
      t.string :upload_content_type
      t.integer :upload_file_size
      t.datetime :upload_updated_at
    end
  end

  def self.down
    drop_table :submissions
  end
end
