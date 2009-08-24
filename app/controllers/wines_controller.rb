class WinesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  layout 'application'
  resource_controller

  index.response do |wants|
    wants.html do 
     @wines = Wine.paginate :page => params[:page]
    end
  end

  create.before do
    object.person = current_person
  end

  create.flash "Votre vin a été ajouté!"
  create.response do |wants|
    wants.html{redirect_to wine_reviews_url(@wine)}
  end

  update.flash {"Votre vin a été mis à jour!"}
  update.response do |wants|
    wants.html{redirect_to wine_reviews_url(@wine)}
  end

  destroy.flash {"Votre vin a été retiré!"}

end
