class AddCategories < ActiveRecord::Migration
  def self.up
    create_table "categories", :force => true do |t|
      t.column :name, :string, :limit => 50
      t.timestamps
    end
    add_column :wines, :category_id, :integer
  end

  def self.down
    drop_table "categories"
    remove_column :wines, :category_id
  end
end
