class WinesController < ApplicationController
  layout 'application'
  
  active_scaffold :wine do |config|
    config.label = "Vins"
    config.columns[:color].label = 'Couleur'
    config.columns[:name].label = 'Nom'
    config.columns[:varieties].label = 'Cépage'
    config.columns[:year].label = 'Année'
    config.columns[:reviews].label = 'Opinions'
    config.list.columns = [:name, :color, :varieties, :year, :reviews]
    config.create.columns = [:name, :color, :varieties, :year]    
    config.update.columns = [:name, :color, :varieties, :year]    
    
    config.create.label = 'Ajouter un nouveau vin'
    config.create.link.label = 'Ajouter un nouveau vin'
    config.search.link.label = 'Recherche'
    config.update.link.label = 'Editer'
    config.delete.link.label = 'Effacer'
    config.show.link.label = 'Afficher'
    config.list.columns.exclude [:created_at, :updated_at]
    config.columns[:color].form_ui = :select
    config.columns[:varieties].clear_link
    #    config.columns[:varieties].form_ui = :select
    
    #   config.columns = [:name, :phone, :company_type, :comments]
    #    list.columns.exclude :comments
    list.sorting = {:name => 'ASC'}
  end
  
  #hook in active_scaffold (so that I can create the children from the many-to-many relationship)
  def before_create_save(record)
    params[:record][:variety_ids].each do |id|
      record.variety_wines.build(:variety_id => id)
    end
  end

  #hook in active_scaffold (so that I can update the children from the many-to-many relationship)
  def before_update_save(record)
    record.variety_wines.clear
    params[:record][:variety_ids].each do |id|
      record.variety_wines.build(:variety_id => id)
    end
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
