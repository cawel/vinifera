class AddCurrentlyAtSaq < ActiveRecord::Migration
  def self.up
    add_column :wines, :currently_at_saq, :boolean, :default => false
  end

  def self.down
    remove_column :wines, :currently_at_saq
  end
end
