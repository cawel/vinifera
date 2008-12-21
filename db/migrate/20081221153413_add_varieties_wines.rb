class AddVarietiesWines < ActiveRecord::Migration
  
  def self.up
    create_table "variety_wines", :force => true do |t|
      t.column :variety_id, :integer
      t.column :wine_id, :integer
    end
  end
  
  def self.down
    drop_table "variety_wines"
  end
  
end