class WinesController < ApplicationController
  before_filter :login_required, :except => [:home, :index, :show]

  layout 'application'
  resource_controller

  def home
    @timeline_events = TimelineEvent.recent
  end

  index.response do |wants|
    wants.html do 
      unless params[:q].nil?
        @wines = Wine.search(params[:q], :order => :name, :page => params[:page])
      else
        @wines = Wine.paginate :page => params[:page]
      end
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
