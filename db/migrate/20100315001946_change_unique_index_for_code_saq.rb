class ChangeUniqueIndexForCodeSaq < ActiveRecord::Migration
  def self.up
    remove_index :wines, :column => :code_saq
    add_index :wines, :code_saq
  end

  def self.down
    remove_index :wines, :column => :code_saq
    add_index :wines, :code_saq, :unique => true
  end
end
