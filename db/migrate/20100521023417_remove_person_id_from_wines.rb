class RemovePersonIdFromWines < ActiveRecord::Migration
  def self.up
    remove_column :wines, :person_id
  end

  def self.down
    add_column :wines, :person_id, :integer
  end
end
