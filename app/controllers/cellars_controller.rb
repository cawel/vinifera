class CellarsController < ApplicationController
  before_filter :load_person

  def index
    @cellar_wines = Cellar.for_person(@person)
  end

  def create
    @cellar_wine = Cellar.new(:person_id => @person.id, :wine_id => params[:wine_id])
    if @cellar_wine.save
      render :text => "Ajout au cellier fait!"
    else
      render :text => "Ajout au cellier non reussi!"
    end
  end

  def destroy 
    cellar = Cellar.find params[:id]
    if cellar.destroy
      flash[:notice] = "Retrait du cellier reussi."
    else
      flash[:notice] = "Erreur lors du retrait du cellier."
    end
      redirect_to :action => :index
  end

  def update_inplace_note
    cellar = Cellar.find params[:id]
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
    @person = Person.find(params[:person_id])
  end
end
