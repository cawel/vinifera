require 'ruby-debug'

# Wine.delete_all
added = 0
already_had = 0

File.open("../scraper/output") do |f|
  name, code_saq, year, cup, category_id, color_id, region_id, country_id, nature_id, format, price, provider, alcool, sub_region_id, appellation_id, flavor_id, image_filename = nil
  f.each do |line|
    name = line.gsub(/^\w+:/,'').strip if line =~ /^nom_produit:/
      code_saq = line.gsub(/^\w+:/,'').strip if line =~ /^code_saq:/
      cup = line.gsub(/^\w+:/,'').strip if line =~ /^cup:/
      format = line.gsub(/^\w+:/,'').strip if line =~ /^format:/
      price = line.gsub(/^\w+:/,'').gsub(',','.').strip.to_f if line =~ /^prix:/
      provider = line.gsub(/^\w+:/,'').strip if line =~ /^fournisseur:/
      alcool = line.gsub(/^[\w+_]*:/,'').strip.to_f if line =~ /^pourcentage_d_alcool:/
      image_filename = line.match(/[0-9]+.+$/)[0].strip if line =~ /^image_url:/

      year = name.scan(/[0-9]{4}/).first
    name = name.sub(/ [0-9]{4}/, '')

      if line =~ /^categorie:/
        category = line.gsub(/^\w+:/,'').strip 
    category_id = Category.find_by_name(category).id 
      end
    if line =~ /^couleur:/
      color = line.gsub(/^\w+:/,'').strip 
      color_id = Color.find_by_name(color).id 
    end
    if line =~ /^region:/
      region = line.gsub(/^\w+:/,'').strip 
      region_id = Region.find_by_name(region).id 
    end
    if line =~ /^sous_region:/
      sub_region = line.gsub(/^\w+:/,'').strip 
      sub_region_id = SubRegion.find_by_name(sub_region).id 
    end
    if line =~ /^pays:/
      country = line.gsub(/^\w+:/,'').strip 
      country_id = Country.find_by_name(country).id 
    end
    if line =~ /^nature:/
      nature = line.gsub(/^\w+:/,'').strip 
      if Nature.find_by_name(nature).nil?
        nature_id = nil
      else
        nature_id = Nature.find_by_name(nature).id 
      end
    end
    if line =~ /^appellation:/
      appellation = line.gsub(/^\w+:/,'').strip 
      appellation_id = Appellation.find_by_name(appellation).id 
    end
    if line =~ /^arome:/
      flavor = line.gsub(/^\w+:/,'').strip 
      flavor = Flavor.find_by_name(flavor).id 
    end
   
    # wine model creation
    if line =~ /#/
      # only take those which fit the natures
      unless nature_id.nil?
        w = Wine.find_by_code_saq_and_year(code_saq, year)
        unless w.nil?
          already_had += 1
          w.update_attributes(:price => price, :times_updated => w.times_updated + 1)
          next
        end
        added += 1
        wine = Wine.create(:name => name, :year => year, :code_saq => code_saq, :cup => cup, :category_id => category_id, :color_id => color_id, 
                           :region_id => region_id, :country_id => country_id, :nature_id => nature_id, :format => format, :price => price,
                           :provider => provider, :alcool => alcool, :sub_region_id => sub_region_id, :appellation_id => appellation_id, 
                           :flavor_id => flavor_id, :image_filename => code_saq + "_g.jpg", :times_updated => 0)
        puts wine.code_saq
        puts wine.errors.full_messages if wine.errors.any?
      end
    name, code_saq, year, cup, category_id, color_id, region_id, country_id, nature_id, format, price, provider, alcool, sub_region_id, appellation_id, flavor_id, image_filename = nil
    end
  end
end

puts "wines added = #{added}"
puts "already had = #{already_had}"
puts "wines count: #{Wine.count}"
