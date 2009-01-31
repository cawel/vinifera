class ReviewsController < ApplicationController
  layout 'application'
  resource_controller
  belongs_to :wine
  
  create.response do |wants|
    wants.html{redirect_to wine_reviews_url(params[:wine_id])}
  end

end
