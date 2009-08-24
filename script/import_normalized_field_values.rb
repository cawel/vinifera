# in order to populate production DB, this script should be as:
# script/runner -e production script/import_normalized_field_values.rb

def import model
  model.delete_all
  File.open("db/normalized_fields_values/#{model.to_s.pluralize}", 'r') do |f|
    f.each do |line|
      value = line.strip
      puts "adding \"#{value}\""
      model.create(:name => value)
    end
  end
  puts "#{model.to_s.pluralize} count: #{model.send :count}\n\n"
end

# the high level code
[Color, Category, Nature, Region, SubRegion, Appellation, Flavor, Country].each do |model|
  import model
end
