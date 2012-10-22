class WinesController < ResourceController::Base
  actions :index, :show
  layout 'application'
  before_filter :login_required, :except => [:home, :index, :show]

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
