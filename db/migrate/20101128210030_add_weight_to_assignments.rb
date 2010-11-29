class AddWeightToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :weight, :float
  end

  def self.down
    remove_column :assignments, :weight
  end
end
