# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  def create
    logout_keeping_session!
    person = Person.authenticate(params[:email], params[:password])
    if person
      self.current_person = person
      new_cookie_flag     = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      
      flash[:notice] = "Session maintenant ouverte avec succes!"
      redirect_back_or_default root_url
    else
      note_failed_signin
      @email       = params[:email]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "Votre session est maintenant terminee."
    redirect_back_or_default root_url
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Nous n'avons pas pu ouvrir une session en tant que \"#{params[:email]}\"."
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
