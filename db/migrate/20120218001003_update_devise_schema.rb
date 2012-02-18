class UpdateDeviseSchema < ActiveRecord::Migration
  def up
    remove_column :users, :remember_token
    add_column :users, :reset_password_sent_at, :datetime
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
