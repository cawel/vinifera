module WinesHelper
  
  def reviews_column(record)
    link_to "#{record.reviews.size}", wine_reviews_url(:wine_id => record.id)
  end
  
end