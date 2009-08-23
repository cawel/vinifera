class AddNatures < ActiveRecord::Migration
  def self.up
    create_table :natures do |t|
      t.column :name,       :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :natures
  end
end
