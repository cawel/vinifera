class Admin::ApplicationController < ApplicationController
  # layout "admin"
  before_filter :non_admin_redirect
  
  def non_admin_redirect
    #if !is_admin?
    #  flash[:notice] = "You need to be an admin to do that."
    #  redirect_back_or_default(:controller => "/accounts", :action => "login")
    #end
  end
end