codes = Wine.all(:select => 'code_saq', :group => 'code_saq', :having => 'count(*) > 1').map &:code_saq
puts "found #{codes.size} wines with at least 2 similar code_saq"
codes.each do |code|
  wines = Wine.find_all_by_code_saq(code, :order => 'year desc')
  ref = wines.shift
  puts "harmonizing #{ref.code_saq} (#{wines.size} times)"
  wines.each do |w|
    w.update_attributes(:country_id => ref.country_id, :region_id => ref.region_id, :sub_region_id => ref.sub_region_id, :appellation_id => ref.appellation_id, :flavor_id => ref.flavor_id, :nature_id => ref.nature_id, :category_id => ref.category_id)
  end
end

