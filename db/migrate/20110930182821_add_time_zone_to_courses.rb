class AddTimeZoneToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :time_zone, :string
  end

  def self.down
    remove_column :courses, :time_zone, :string
  end
end
