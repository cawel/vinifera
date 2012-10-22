class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.float :lat
      t.float :lng
      
      t.timestamps
    end
    add_column :wines, :country_id, :integer
    insert_countries
  end
  
  def self.down
    drop_table :countries
    remove_column :wines, :country_id
  end
  
  def self.insert_countries
    File.open("db/countries.sql") do |f|
      while (line = f.gets) 
        execute line
      end
    end
  end
  
end