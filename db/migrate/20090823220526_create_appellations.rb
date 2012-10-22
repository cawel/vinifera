class CreateAppellations < ActiveRecord::Migration
  def self.up
    create_table :appellations do |t|
      t.string :name

      t.timestamps
    end
    add_column :wines, :appellation_id, :integer
  end

  def self.down
    drop_table :appellations
    remove_column :wines, :appelation_id
  end
end
