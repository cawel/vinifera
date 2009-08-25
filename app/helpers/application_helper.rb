# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def editable_wine?(wine, &block)
    if current_person.andand.admin || current_person == wine.person
      block.call
    else
      "&nbsp;"
    end
  end
  
  def editable_review?(review, &block)
    if (review.person == current_person) || current_person.andand.admin
      block.call
    else
      "&nbsp;"
    end
  end
  
  def person_display_name person
    if person.nil?
      return "[no user name]"
    end
    person.name.blank? ? person.email : person.name
  end
  
  def format_review_comment text
    simple_format word_wrap((text), :line_width => 100)
  end
  
  def country_flag country
    image_path = get_flag_image_path(country)
    image_path.blank?? '' : "<img class='flag' title='#{country.name}' src=\"#{image_path}\"/>"   
  end 
  
  def field_exists? field
    yield unless field.nil?
  end

  private
  def get_flag_image_path(country)
    image_path = "/images/flags/" + country.code.downcase + ".gif"
    File.exists?("#{RAILS_ROOT}/public/#{image_path}") ? image_path : nil
  end
  
end
