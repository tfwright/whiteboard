class RenameUploads < ActiveRecord::Migration
  def self.up
    rename_table :uploads, :documents
  end

  def self.down
    rename_table :documents, :uploads
  end
end
