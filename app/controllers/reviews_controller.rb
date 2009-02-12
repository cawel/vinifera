class ReviewsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  layout 'application'
  resource_controller
  belongs_to :wine
  
  create.before do
    object.person = current_person
  end
  
#  create.response do |wants|
#    wants.html{ redirect_to wine_reviews_url(params[:wine_id]) }
#  end
  
end
