# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  DELETE_CONFIRM_MESSAGE = "Etes vous certain?"

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
    person.name.blank? ? h(person.email) : h(person.name)
  end

  def format_user_content text
    simple_format(h text)
  end

  def format_date datetime
    I18n.localize(datetime.to_date, :format => :short) 
  end

  def wine_full_name wine
    wine.name + " " + wine.year.to_s
  end

  def country_flag country
    return nil if Rails.env.test?
    image_path = get_flag_image_path(country)
    image_path.blank?? '' : "<img class='flag' title='#{country.name}' src=\"#{image_path}\"/>"   
  end 

  def field_exists? field
    yield unless field.nil?
  end

  def stars_rating rating
    case rating.id
    when 1; image_tag("stars/1star.gif")
    when 2; image_tag("stars/2star.gif")
    when 3; image_tag("stars/3star.gif")
    when 4; image_tag("stars/4star.gif")
    when 5; image_tag("stars/5star.gif")
    end
  end

  def glass_image_filename wine
    if wine.color.name == "Rouge" 
      "glasses/red_small.png"
    else
      "glasses/white_small.png"
    end
  end

  def bottle_image wine
    filename = "/images/bottles/#{wine.code_saq}.jpg"
    if File.exists?("#{RAILS_ROOT}/public" + filename)
      image_tag filename, :title => @wine.name
    else
      ""
    end
  end

  def select_image_filename link
    if link =~ /busurleweb/
      "wine_news/bu_sur_le_web.jpg"
    elsif link =~ /mechantraisin/
      "wine_news/mechant_raison.png"
    elsif link =~ /ChacunSaBouteille/
      "wine_news/remy_charest.jpg"
    else
      "wine_news/cyberpresse.png"
    end
  end
  
  def clean_post_description description
    # Remy Charest (achacunsabouteille)
    description = description.gsub(/&amp;#8217;/, "'").gsub("&amp;#8230", "...")
      # Aurelia Filion (bu sur le web)
      description = description.gsub(/\&lt.*?gt\;/, '').gsub(/\n/,'') 
  end
  
  include WillPaginate::ViewHelpers 
  def will_paginate_with_i18n(collection, options = {}) 
    will_paginate_without_i18n(collection, options.merge(:previous_label => I18n.t('will_paginate.previous'), :next_label => I18n.t('will_paginate.next'))) 
  end 
  alias_method_chain :will_paginate, :i18n  

  private
  def get_flag_image_path(country)
    image_path = "/images/flags/" + country.code.downcase + ".gif"
    File.exists?("#{RAILS_ROOT}/public/#{image_path}") ? image_path : nil
  end

  def user_turf?
    @person.id == current_person.andand.id
  end

end
