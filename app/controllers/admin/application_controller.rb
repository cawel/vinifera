class Admin::ApplicationController < ApplicationController
  # layout "admin"
  before_filter :non_admin_redirect
  
  def non_admin_redirect
    if !current_person.andand.admin
      flash[:notice] = "You need to be an admin in order to access the admin interface."
      redirect_to login_url
    end
  end
end