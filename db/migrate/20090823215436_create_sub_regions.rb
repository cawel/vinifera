class CreateSubRegions < ActiveRecord::Migration
  def self.up
    create_table :sub_regions do |t|
      t.string :name

      t.timestamps
    end
    add_column :wines, :sub_region_id, :integer
  end

  def self.down
    drop_table :sub_regions
    remove_column :wines, :sub_region_id
  end
end
