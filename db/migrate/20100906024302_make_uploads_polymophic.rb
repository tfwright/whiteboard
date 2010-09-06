class MakeUploadsPolymophic < ActiveRecord::Migration
  def self.up
    rename_column :uploads, :course_id, :attachable_id
    add_column :uploads, :attachable_type, :string
  end

  def self.down
    rename_column :uploads, :attachable_id, :course_id
    remove_column :uploads, :attachable_type
  end
end
