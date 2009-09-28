class ApplicationController < ActionController::Base
  include AuthenticatedSystem, HoptoadNotifier::Catcher

  helper :all
  before_filter :configure_mailers
  before_filter :localizate
  before_filter :top_wines
  before_filter :top_contributers
  
  def localizate
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = 'fr-CA'
  end
  
  def home
    @timeline_events = TimelineEvent.recent
    render :template => 'layouts/home'
  end

  def top_contributers
    @top_contributers = Review.top_contributers
  end

  def top_wines
    @top_wines = Wine.top_wines
  end

  def local_request?
    false
  end

  def rescue_action_in_public(exception)
    if exception.is_a? ActionController::RoutingError 
      render :template => "/layouts/404.html.erb", :layout => true, :status => 404
    else
      render :template => "/layouts/500.html.erb", :layout => true, :status => 500
    end
    notify_hoptoad(exception)
  end

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  protected
    def configure_mailers
      PasswordResetMailer.configure(request)
    end
end
