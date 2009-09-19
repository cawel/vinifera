class ApplicationController < ActionController::Base
  include AuthenticatedSystem, HoptoadNotifier::Catcher

  helper :all
  before_filter :configure_mailers
  before_filter :localizate
  
  def localizate
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = 'fr-CA'
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