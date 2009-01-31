class WinesController < ApplicationController
  layout 'application'
  resource_controller
  
  create.response do |wants|
    wants.html{redirect_to wines_url}
  end
  
end
