class AddWinesPersonId < ActiveRecord::Migration
  def self.up
    add_column :wines, :person_id, :integer, :null => false, :default => 0
  end
  
  def self.down
    remove_column :wines, :person_id
  end
end