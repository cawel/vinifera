# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def editable? &block
    if current_person
      block.call
    else
      "&nbsp;"
    end
  end
  
  def editable_review?(review, &block)
    if review.person == current_person
      block.call
    else
      "&nbsp;"
    end
  end
  
  
end