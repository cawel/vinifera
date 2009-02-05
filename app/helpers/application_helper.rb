# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def editable_wine? &block
    if current_person.andand.admin
      block.call
    else
      "&nbsp;"
    end
  end
  
  def editable_review?(review, &block)
    if (review.person == current_person) || current_person.admin
      block.call
    else
      "&nbsp;"
    end
  end
  
  
end