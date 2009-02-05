class WinesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  layout 'application'
  resource_controller
  
  create.before do
    object.person = current_person
  end
  
  create.response do |wants|
    wants.html{redirect_to wines_url}
  end
  
end
