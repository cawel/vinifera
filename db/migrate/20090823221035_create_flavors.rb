class CreateFlavors < ActiveRecord::Migration
  def self.up
    create_table :flavors do |t|
      t.string :name

      t.timestamps
    end
    add_column :wines, :flavor_id, :integer
  end

  def self.down
    drop_table :flavors
    remove_column :wines, :flavor_id
  end
end
