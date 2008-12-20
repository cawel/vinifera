class ReviewsController < ApplicationController
  
  layout 'application'
  
  active_scaffold :review do |config|
    config.list.columns.exclude [:created_at, :updated_at]
    config.label = 'Opinions'
    config.columns[:comment].label = 'Commentaire'
    config.columns[:person].label = 'Usager'
    config.columns[:rating].label = 'Cote'
    config.create.label = 'Donner votre opinion'
    config.create.link.label = 'Donner votre opinion'
    config.search.link.label = 'Recherche'
    config.update.link.label = 'Editer'
    config.delete.link.label = 'Effacer'
    config.show.link.label = 'Afficher'
    
    config.create.columns = [:comment, :rating]
    config.columns[:rating].form_ui = :select
    config.update.columns.exclude :person
    list.sorting = {:rating => 'DESC'}
  end
  
  def index
    @wine = Wine.find params[:wine_id]
  end
  
  def before_create_save(record)
    record.wine_id = params[:wine_id]
    record.person = current_person
  end
  
  # only authenticated users are authorized to create records
  def create_authorized?
    current_person
  end
  
  def delete_authorized?
    current_person
  end
  
  def update_authorized?
    current_person
  end
  
end
