ActionController::Routing::Routes.draw do |map|
  
  # backend
  map.namespace(:admin) do |admin|
    admin.resources :ratings, :active_scaffold => true
    admin.resources :varieties, :active_scaffold => true
    admin.resources :colors, :active_scaffold => true
  end
  
  # frontend
  map.resources :wines, :as => "vins", :only => [:index]  do |wine|
    wine.resources :reviews, :as => "critiques", :only => [:index, :new, :create, :edit, :update, :destroy]
  end

  map.root                                      :controller => 'timeline_events', :action => 'index'
  map.activity_feed 'dernieres_critiques.rss',  :controller => 'timeline_events', :action => 'index', :format => 'rss'
  map.search        '/resultats-de-recherche',  :controller => 'wines',           :action => 'index'

  map.about         '/a-propos',                :controller => 'contents',        :action => 'about'
  map.contact       '/contact',                 :controller => 'contents',        :action => 'contact'
  map.ratings_help  '/signification-des-cotes', :controller => 'contents',        :action => 'ratings_help'
  map.wine_news     '/nouvelles-monde-du-vin',  :controller => 'contents',        :action => 'wine_news'
  
  map.login         '/ouvrir-session',          :controller => 'sessions',        :action => 'new'
  map.logout        '/terminer-session',        :controller => 'sessions',        :action => 'destroy'
  
  map.register      '/enregistrer',             :controller => 'people',          :action => 'create'
  map.signup        '/creer-compte',            :controller => 'people',          :action => 'new'
  
  map.reset_password '/reset_password',         :controller => 'password_resets', :action => 'new',    :conditions => {:method => :get}
  map.reset_password '/reset_password',         :controller => 'password_resets', :action => 'create', :conditions => {:method => :post}
  
  map.connect '/account', :controller => 'accounts', :action => 'edit'
  
  map.resources :people, :as => 'compte', :only => [:show, :new, :create, :edit, :update] do |person|
    person.reviews_index 'critiques', :controller => 'reviews', :action => 'user_reviews_index'
    person.resources :cellar_wines, :as => "cellier", :only => [:index, :create, :destroy]
  end

  map.update_inplace_note '/cellar_wines/update_inplace_note', :controller => 'cellar_wines', :action => 'update_inplace_note'

  map.resource :session, :account
end
