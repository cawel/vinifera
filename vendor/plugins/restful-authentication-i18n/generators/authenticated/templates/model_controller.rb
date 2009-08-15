class <%= model_controller_class_name %>Controller < ApplicationController
  # Be sure to include AuthenticationSystem and localizate in Application Controller instead
  include AuthenticatedSystem
  <% if options[:stateful] %>
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :localizate, :find_<%= file_name %>, :only => [:suspend, :unsuspend, :destroy, :purge]
  <% else %>
  before_filter :localizate
  <% end %>
  def localizate
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # render new.rhtml
  def new
    @<%= file_name %> = <%= class_name %>.new
  end
 
  def create
    logout_keeping_session!
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
<% if options[:stateful] -%>
    @<%= file_name %>.register! if @<%= file_name %> && @<%= file_name %>.valid?
    success = @<%= file_name %> && @<%= file_name %>.valid?
<% else -%>
    success = @<%= file_name %> && @<%= file_name %>.save
<% end -%>
    if success && @<%= file_name %>.errors.empty?
      <% if !options[:include_activation] -%>
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_<%= file_name %> = @<%= file_name %> # !! now logged in
      <% end -%>redirect_back_or_default('/')
      <% if options[:include_activation] -%>
        flash[:notice] = I18n.t(:signup_complete_with_activation)
      <% else -%>
        flash[:notice] = I18n.t(:signup_complete)
      <% end %>
    else
      flash[:error]  = I18n.t(:signup_problem)
      render :action => 'new'
    end
  end
<% if options[:include_activation] %>
  def activate
    logout_keeping_session!
    <%= file_name %> = <%= class_name %>.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && <%= file_name %> && !<%= file_name %>.active?
      <%= file_name %>.activate!
      flash[:notice] = I18n.t(:signup_complete_and_do_login)
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = I18n.t(:blank_activation_code)
      redirect_back_or_default('/')
    else 
      flash[:error]  = I18n.t(:bogus_activation_code, :model => '<%= file_name %>')
      redirect_back_or_default('/')
    end
  end
<% end %><% if options[:stateful] %>
  def suspend
    @<%= file_name %>.suspend! 
    redirect_to <%= model_controller_routing_name %>_path
  end

  def unsuspend
    @<%= file_name %>.unsuspend! 
    redirect_to <%= model_controller_routing_name %>_path
  end

  def destroy
    @<%= file_name %>.delete!
    redirect_to <%= model_controller_routing_name %>_path
  end

  def purge
    @<%= file_name %>.destroy
    redirect_to <%= model_controller_routing_name %>_path
  end
  
  # There's no page here to update or destroy a <%= file_name %>.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_<%= file_name %>
    @<%= file_name %> = <%= class_name %>.find(params[:id])
  end
<% end -%>
end
