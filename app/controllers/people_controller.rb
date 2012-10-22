class PeopleController < ResourceController::Base
  actions :new, :create, :edit, :update, :show
  before_filter :login_required,            :only => [:edit, :update]
  before_filter :prevent_impersonification, :only => [:edit, :update]
  
  show do
    before    { @reviews = Review.find_all_by_person_id(params[:id], :order => 'created_at desc') }
  end

  create do
    before     :logout_keeping_session!
    after      { self.current_person = @person }
    flash      I18n.t(:signup_complete)
    wants.html { redirect_back_or_default(root_url) } 
  end
  
  update.flash "Votre compte a été mis a jour!"
  
  def prevent_impersonification
    if current_person != Person.find_by_id(params[:id])
      flash[:notice] = "Il est impossible de changer le compte de quelqu'un d'autre. Il est seulement possible de changer son propre compte."
      redirect_to person_url(current_person)
    end
  end
  
end
