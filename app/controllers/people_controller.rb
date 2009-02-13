class PeopleController < ResourceController::Base
  actions :new, :create, :edit, :update, :show
  before_filter :login_required, :only => [:edit, :update]
  before_filter :prevent_inpersonification, :only => [:edit, :update]
  
  before_filter :localizate
  
  def localizate
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  create do
    before     :logout_keeping_session!
    after      { self.current_person = @person }
    flash      I18n.t(:signup_complete)
    wants.html { redirect_back_or_default(root_url) } 
  end
  
  def prevent_inpersonification
    if current_person.andand != Person.find_by_id(params[:id])
      flash[:notice] = "Il est impossible d'editer le compte de quelqu'un d'autre. Il est seulement possible d'editer son propre compte."
      redirect_to edit_person_url(current_person)
    end
  end
  
end
