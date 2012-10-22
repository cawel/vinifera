class CreateCellars < ActiveRecord::Migration
  def self.up
    create_table :cellars do |t|
      t.references :wine, :null => false
      t.references :person, :null => false
      t.column :note, :string

      t.timestamps
    end
  end

  def self.down
    drop_table :cellars
  end
end
