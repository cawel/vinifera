class PasswordResetsController < ApplicationController
  def create
    @person = Person.find_by_email(params[:email])
    
    if @person.nil?
      flash.now[:notice] = "Aucun utilisateur avec cette adresse email n'a ete trouve :("
      render :action => "new"
    else
      @person.create_password_reset_code
      flash.now[:notice] = "Un email vous a ete envoyé avec les instructions pour réinitialiser votre mot de passe."
    end
  end
end
