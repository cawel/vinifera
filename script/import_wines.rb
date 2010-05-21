require 'ruby-debug'

# Wine.delete_all
added = 0
already_had = 0

InputBottle = Struct.new(:name, :code_saq, :year, :cup, :category_id, :color_id, :region_id, :country_id, :nature_id, :format, :price, :provider, :alcool, :sub_region_id, :appellation_id, :flavor_id, :image_filename)

class InputBottle
  def to_hash
    members.inject({}){|memo, m| memo[m.to_sym] = send(m.to_sym);  memo}
  end
end

File.open("../scraper/output") do |f|

  input = InputBottle.new
  f.each do |line|

    input.code_saq = line.gsub(/^\w+:/,'').strip if line =~ /^code_saq:/
      input.cup = line.gsub(/^\w+:/,'').strip if line =~ /^cup:/
      input.format = line.gsub(/^\w+:/,'').strip if line =~ /^format:/
      input.price = line.gsub(/^\w+:/,'').gsub(',','.').strip.to_f if line =~ /^prix:/
      input.provider = line.gsub(/^\w+:/,'').strip if line =~ /^fournisseur:/
      input.alcool = line.gsub(/^[\w+_]*:/,'').strip.to_f if line =~ /^pourcentage_d_alcool:/
      input.image_filename = line.match(/[0-9]+.+$/)[0].strip if line =~ /^image_url:/

      if line =~ /^nom_produit:/
        input.name = line.gsub(/^\w+:/,'').strip 
        input.year = input.name.scan(/[0-9]{4}/).first
        input.name = input.name.sub(/ [0-9]{4}/, '')
      end

    if line =~ /^categorie:/
      category = line.gsub(/^\w+:/,'').strip 
      input.category_id = Category.find_by_name(category).id 
    end
    if line =~ /^couleur:/
      color = line.gsub(/^\w+:/,'').strip 
      input.color_id = Color.find_by_name(color).id 
    end
    if line =~ /^region:/
      region = line.gsub(/^\w+:/,'').strip 
      begin
        input.region_id = Region.find_by_name(region).id 
      rescue RuntimeError
        puts "adding region: #{region}"
        Region.create(:name => region)
        retry
      end
    end
    if line =~ /^sous_region:/
      sub_region = line.gsub(/^\w+:/,'').strip 
      begin
        input.sub_region_id = SubRegion.find_by_name(sub_region).id 
      rescue RuntimeError
        puts "adding subregion #{sub_region}"
        SubRegion.create(:name => sub_region)
        retry
      end
    end
    if line =~ /^pays:/
      country = line.gsub(/^\w+:/,'').strip 
      begin
        input.country_id = Country.find_by_name(country).id 
      rescue RuntimeError
        puts "adding country #{country}"
        Country.create(:name => country)
        retry
      end
    end
    if line =~ /^nature:/
      nature = line.gsub(/^\w+:/,'').strip 
      unless Nature.find_by_name(nature).nil?
        input.nature_id = Nature.find_by_name(nature).id 
      end
    end
    if line =~ /^appellation:/
      appellation = line.gsub(/^\w+:/,'').strip 
      begin
        input.appellation_id = Appellation.find_by_name(appellation).id 
      rescue RuntimeError
        puts "adding appellation #{appellation}"
        Appellation.create(:name => appellation)
        retry
      end
    end
    if line =~ /^arome:/
      flavor = line.gsub(/^\w+:/,'').strip 
      begin
      input.flavor_id = Flavor.find_by_name(flavor).id 
      rescue RuntimeError
        puts "adding flavor #{flavor}"
        Flavor.create(:name => flavor)
        retry
      end
    end
   
    # wine model creation
    if line =~ /#/
      # only take those which fit the natures
      unless input.nature_id.nil?
        w = Wine.find_by_code_saq_and_year(input.code_saq, input.year)
        if w.nil?
          added += 1
          wine = Wine.create(:name => input.name, :year => input.year, :code_saq => input.code_saq, :cup => input.cup, :category_id => input.category_id, :color_id => input.color_id, 
                             :region_id => input.region_id, :country_id => input.country_id, :nature_id => input.nature_id, :format => input.format, :price => input.price,
                             :provider => input.provider, :alcool => input.alcool, :sub_region_id => input.sub_region_id, :appellation_id => input.appellation_id, 
                             :flavor_id => input.flavor_id, :image_filename => input.code_saq + "_g.jpg", :times_updated => 0)
          puts wine.errors.full_messages if wine.errors.any?
        else
          already_had += 1
          # update wine with the fresh data
          w.update_attributes(input.to_hash)
          w.update_attributes(:times_updated => w.times_updated + 1)
        end
      end
    input = InputBottle.new
    end
  end
end

puts "wines added = #{added}"
puts "already had = #{already_had}"
puts "wines count: #{Wine.count}"
