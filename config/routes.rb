ActionController::Routing::Routes.draw do |map|
  
  # backend
  map.namespace(:admin) do |admin|
    admin.resources :ratings, :active_scaffold => true
    admin.resources :varieties, :active_scaffold => true
    admin.resources :colors, :active_scaffold => true
  end
  
  # frontend
  map.resources :wines, :as => "vins" do |wine|
    wine.resources :reviews, :as => "critiques"
  end
  
  map.root                                      :controller => 'application', :action => 'home'
  map.search        '/resultats-de-recherche',  :controller => 'wines',       :action => 'index'

  map.about         '/a-propos',                :controller => 'contents',    :action => 'about'
  map.contact       '/contact',                 :controller => 'contents',    :action => 'contact'
  map.ratings_help  '/signification-des-cotes', :controller => 'contents',    :action => 'ratings_help'
  
  map.login         '/ouvrir-session',          :controller => 'sessions',    :action => 'new'
  map.logout        '/terminer-session',        :controller => 'sessions',    :action => 'destroy'
  
  map.register      '/enregistrer',             :controller => 'people',      :action => 'create'
  map.signup        '/creer-compte',            :controller => 'people',      :action => 'new'
  
  # map.reset_password '/reset_password',         :controller => 'password_resets', :action => 'new',    :conditions => {:method => :get}
  # map.reset_password '/reset_password',         :controller => 'password_resets', :action => 'create', :conditions => {:method => :post}
  
  map.connect '/account', :controller => 'accounts', :action => 'edit'
  
  map.resources :people, :as => 'compte' do |person|
    person.reviews_index 'critiques', :controller => 'reviews', :action => 'user_index'
  end

  map.resource  :session, :account
end
