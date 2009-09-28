class WinesController < ResourceController::Base
  actions :index, :show
  before_filter :login_required, :except => [:home, :index, :show]

  layout 'application'
  resource_controller

  index.response do |wants|
    wants.html do 
      unless params[:q].nil?
        @wines = Wine.search(params[:q], :order => :name, :page => params[:page])
      else
        @wines = Wine.paginate :page => params[:page]
      end
    end
  end

end
