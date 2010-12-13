class RemoveCodeFromCourses < ActiveRecord::Migration
  def self.up
    remove_column :courses, :code
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
