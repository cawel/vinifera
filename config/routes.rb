Vinifera::Application.routes.draw do
  # backend
  namespace(:admin) do
    resources :ratings, :active_scaffold => true
    resources :varieties, :active_scaffold => true
    resources :colors, :active_scaffold => true
  end 

  # frontend
  resources :wines, :as => "vins", :only => [:index]  do
    resources :reviews, :as => "critiques", :only => [:index, :new, :create, :edit, :update, :destroy]
  end 

  root                                      :controller => 'timeline_events', :action => 'index'
  match 'flux_activite.rss',        :controller => 'timeline_events', :action => 'index', :format => 'rss', :as => :activity_feed
  match 'search',        '/resultats-de-recherche',  :controller => 'wines',           :action => 'index', :as => :search

  # about         '/a-propos',                :controller => 'contents',        :action => 'about'
  # contact       '/contact',                 :controller => 'contents',        :action => 'contact'
  # ratings_help  '/signification-des-cotes', :controller => 'contents',        :action => 'ratings_help'
  # wine_news     '/nouvelles-monde-du-vin',  :controller => 'contents',        :action => 'wine_news'
  # twitter_feed  '/twitter-feed',            :controller => 'contents',        :action => 'twitter_feed'

  match '/ouvrir-session',          :controller => 'sessions',        :action => 'new', :as => :login
  match '/terminer-session',        :controller => 'sessions',        :action => 'destroy', :as => :logout

  # register      '/enregistrer',             :controller => 'people',          :action => 'create'
  # signup        '/creer-compte',            :controller => 'people',          :action => 'new'

  # reset_password '/reset_password',         :controller => 'password_resets', :action => 'new',    :conditions => {:method => :get}
  # reset_password '/reset_password',         :controller => 'password_resets', :action => 'create', :conditions => {:method => :post}

  match '/account', :controller => 'accounts', :action => 'edit'

  resources :people, :as => 'compte', :only => [:show, :new, :create, :edit, :update] do 
    match 'critiques', :controller => 'reviews', :action => 'user_reviews_index', :as => :reviews_index
    resources :cellar_wines, :as => "cellier", :only => [:index, :create, :destroy]
  end 

  # update_inplace_note '/cellar_wines/update_inplace_note', :controller => 'cellar_wines', :action => 'update_inplace_note'

  resource :session, :account
end
