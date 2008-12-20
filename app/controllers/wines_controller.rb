class WinesController < ApplicationController
  layout 'application'
  
  active_scaffold :wine do |config|
    config.label = "Vins"
    config.columns[:color].label = 'Couleur'
    config.columns[:name].label = 'Nom'
    config.columns[:variety].label = 'Cépage'
    config.columns[:year].label = 'Année'
    config.columns[:reviews].label = 'Opinions'
    config.list.columns = [:name, :color, :variety, :year, :reviews]
    config.create.columns = [:name, :color, :variety, :year]    
    config.update.columns = [:name, :color, :variety, :year]    
    
    config.create.label = 'Ajouter un nouveau vin'
    config.create.link.label = 'Ajouter un nouveau vin'
    config.search.link.label = 'Recherche'
    config.update.link.label = 'Editer'
    config.delete.link.label = 'Effacer'
    config.show.link.label = 'Afficher'
    config.list.columns.exclude [:created_at, :updated_at]
    config.columns[:color].form_ui = :select
    config.columns[:variety].clear_link
    config.columns[:variety].form_ui = :select
    
    #   config.columns = [:name, :phone, :company_type, :comments]
    #    list.columns.exclude :comments
    list.sorting = {:name => 'ASC'}
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
