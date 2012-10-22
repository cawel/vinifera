class AddYearToWine < ActiveRecord::Migration
  def self.up
    Wine.all.each do |w|
      year = w.name.scan(/[0-9]{4}/).first

      if year
        w.name = w.name.sub(year, '').chop
        w.year = year
        w.save!
      end
    end
  end

  def self.down
  end
end
