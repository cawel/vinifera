class AddTimesUpdatedInWinesTable < ActiveRecord::Migration

  def self.up
    rename_column :wines, :currently_at_saq, :times_updated
    change_column :wines, :times_updated, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :wines, :times_updated, :boolean
    rename_column :wines, :times_updated, :currently_at_saq
  end

end
