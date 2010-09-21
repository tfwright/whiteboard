class AddAcceptsSubmissionsFlagToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :accepting_submissions, :boolean
  end

  def self.down
    remove_column :assignments, :accepting_submissions
  end
end
