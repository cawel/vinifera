require 'ruby-debug'

images_fetched = 0

Wine.all.each do |wine|
  unless File.exists?("public/images/bottles/#{wine.code_saq}.jpg")
    puts "fetching #{wine.code_saq}..."
    `curl -L "http://www.saq.com/wcsstore/saqcom/images_produits/#{wine.code_saq}_g.jpg" > public/images/bottles/new/#{wine.code_saq}.jpg`
    images_fetched += 1
  end
end

puts "images fetched: #{images_fetched}"
