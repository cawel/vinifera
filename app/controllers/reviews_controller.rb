class ReviewsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :check_if_user_has_reviewed_wine_yet, :only => [:new]
  
  layout 'application'
  resource_controller
  belongs_to :wine
  
  create.before do
    object.person = current_person
  end
  
  create.flash {"Votre opinion a été sauvegardée!"}
  create.response do |wants|
    wants.html{ redirect_to wine_reviews_url(params[:wine_id]) }
  end
  
  update.flash {"Votre opinion a été mise à jour!"}
  update.response do |wants|
    wants.html{ redirect_to wine_reviews_url(params[:wine_id]) }
  end
  
  private
  def check_if_user_has_reviewed_wine_yet
    @review = Review.find_by_wine_id_and_person_id(params[:wine_id], current_person.id)
    if @review
      flash[:notice] = "Vous avez déjà donné une opinion pour ce vin. Vous pouvez la modifier si vous voulez."
      redirect_to edit_wine_review_url(@review.wine, @review)
    end
  end
  
end
