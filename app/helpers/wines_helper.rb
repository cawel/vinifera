module WinesHelper
  
  def reviews_column(record)
    link_to "#{record.reviews.size}", wine_reviews_url(:wine_id => record.id)
  end
  
  def varieties_form_column(record, input_name)
    collection_select :record, :variety_ids,
        Variety.find(:all), :id, :name, {},
        :multiple => true,
        :name => 'record[variety_ids][]', :size => 15
  end
  
end