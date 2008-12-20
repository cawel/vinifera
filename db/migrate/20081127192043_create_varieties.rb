class CreateVarieties < ActiveRecord::Migration
  def self.up
    create_table :varieties do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :varieties
  end
end
