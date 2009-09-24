class ChangeWinesDecimalFields < ActiveRecord::Migration
  def self.up
    change_column :wines, :price, :decimal, :precision => 6, :scale => 2
    change_column :wines, :alcool, :decimal, :precision => 5, :scale => 2
  end

  def self.down
    change_column :wines, :price, :integer
    change_column :wines, :alcool, :integer
  end
end
