class DropColors < ActiveRecord::Migration
  def self.up
    drop_table :colors
  end

  def self.down
    create_table :colors do |t|
      t.string :name

      t.timestamps
    end
  end
end
