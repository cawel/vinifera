require 'ruby-debug'

images_fetched = 0
count = Wine.count

Wine.all.each_with_index do |wine, index|
  unless File.exists?("public/images/bottles/#{wine.code_saq}.jpg") || File.exists?("public/images/bottles/new/#{wine.code_saq}.jpg")
    puts "fetching #{wine.code_saq}..."
    `curl -L "http://www.saq.com/wcsstore/saqcom/images_produits/#{wine.code_saq}_g.jpg" > public/images/bottles/new/#{wine.code_saq}.jpg`
    images_fetched += 1
  end
  sleep 0.1
  puts "#{index} / #{count}"
end

puts "images fetched: #{images_fetched}"
