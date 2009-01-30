class ReviewsController < ApplicationController
  
  layout 'application'
  
  def index
    @wine = Wine.find params[:wine_id]
  end
  
end
