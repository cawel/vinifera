class WinesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  layout 'application'
  resource_controller
  
  create.before do
    object.person = current_person
  end

  create.flash "Votre vin a été ajouté!"
  create.response do |wants|
    wants.html{redirect_to wines_url}
  end
  
  update.flash {"Votre vin a été mis à jour!"}
  update.response do |wants|
    wants.html{redirect_to wines_url}
  end
  
  destroy.flash {"Votre vin a été retiré!"}
  
end
