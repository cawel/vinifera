# This controller handles the login/logout function of the site.  
class <%= controller_class_name %>Controller < ApplicationController
  # Be sure to include AuthenticationSystem and localizate in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :localizate
  
  def localizate
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    <%= file_name %> = <%= class_name %>.authenticate(params[:login], params[:password])
    if <%= file_name %>
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_<%= file_name %> = <%= file_name %>
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = I18n.t(:logged_in)
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = I18n.t(:logged_out)
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = I18n.t(:login_failed, :login => params[:login])
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
