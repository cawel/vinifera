class AddBunchOtherWineFields < ActiveRecord::Migration
  def self.up
    change_table :wines do |t|
      t.column :code_saq, :string
      t.column :cup, :string
      t.column :nature_id, :integer
      t.column :format, :string
      t.column :price, :decimal
      t.column :provider, :string
      t.column :alcool, :decimal
      t.column :image_filename, :string
    end
    add_index :wines, :code_saq, :unique => true
  end

  def self.down
  end
end
