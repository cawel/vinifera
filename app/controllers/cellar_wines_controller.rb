class CellarWinesController < ApplicationController
  before_filter :login_required, :except => [:index]
  before_filter :load_person

  def index
    @cellar_wines = CellarWine.for_person(@person)
    @menu_cellar = true if @person == current_person
  end

  def create
    @cellar_wine = CellarWine.new(:person_id => @person.id, :wine_id => params[:wine_id])
    if @cellar_wine.save
      render :text => "Bouteille au cellier!"
    else
      render :text => "Probleme lors de l'ajout au cellier!"
    end
  end

  def destroy 
    cellar = CellarWine.find params[:id]
    if cellar.destroy
      flash[:notice] = "#{cellar.wine.name} a été retiré de votre cellier."
    else
      flash[:notice] = "Erreur lors du retrait du cellier."
    end
      redirect_to :action => :index
  end

  def update_inplace_note
    cellar = CellarWine.find params[:id]
    value = params[:update_value]
    cellar.update_attribute(:note, value)
    if value.present?
    render :text => value
    else
      render :text => '[Cliquer pour editer]'
    end
  end

  private
  def load_person
    @person = Person.find_by_id(params[:person_id])
    if @person.nil?
      flash[:error] = "Cet usager n'existe pas."
      redirect_to root_url
      false
    end
  end
end
