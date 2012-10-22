class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :rating_id
      t.integer :wine_id
      t.text :comment
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
