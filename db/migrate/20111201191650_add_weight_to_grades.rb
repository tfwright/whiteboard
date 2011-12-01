class AddWeightToGrades < ActiveRecord::Migration
  def self.up
    add_column :grades, :weight, :float
  end

  def self.down
    remove_column :grades, :weight
  end
end
