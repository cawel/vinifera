class AddAdminFlag < ActiveRecord::Migration
  def self.up
    add_column :people, :admin, :boolean, :default => false
  end
  
  def self.down
    remove_column :people, :admin
  end
end
