class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table "regions", :force => true do |t|
      t.column :name, :string, :limit => 50
      t.timestamps
    end
    add_column :wines, :region_id, :integer
  end

  def self.down
    drop_table :regions
    remove_column :wines, :region_id
  end
end
