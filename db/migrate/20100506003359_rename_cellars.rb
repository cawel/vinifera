class RenameCellars < ActiveRecord::Migration
  def self.up
    rename_table :cellars, :cellar_wines
  end

  def self.down
    rename_table :cellar_wines, :cellars
  end
end
