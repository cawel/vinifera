ActionController::Routing::Routes.draw do |map|
  
  # backend
  map.namespace(:admin) do |admin|
    admin.resources :ratings, :active_scaffold => true
    admin.resources :varieties, :active_scaffold => true
    admin.resources :colors, :active_scaffold => true
  end
  
  # frontend
  map.resources :wines do |wine|
    wine.resources :reviews
  end
  
  map.root                   :controller => 'wines', :action => 'home'
  map.search    '/search',   :controller => 'wines', :action => 'index'

  map.about         '/a-propos',    :controller => 'contents', :action => 'about'
  map.contact       '/contact',  :controller => 'contents', :action => 'contact'
  map.ratings_help  '/signification-des-cotes',  :controller => 'contents', :action => 'ratings_help'
  
  map.login     '/login',    :controller => 'sessions',    :action => 'new'
  map.logout    '/logout',   :controller => 'sessions',    :action => 'destroy'
  
  map.register  '/register', :controller => 'people',     :action => 'create'
  map.signup    '/signup',   :controller => 'people',     :action => 'new'
  
  map.reset_password '/reset_password', :controller => 'password_resets', :action => 'new',    :conditions => {:method => :get}
  map.reset_password '/reset_password', :controller => 'password_resets', :action => 'create', :conditions => {:method => :post}
  
  map.connect '/account', :controller => 'accounts', :action => 'edit'
  
  map.resources :people, :as => 'usager' do |person|
    person.reviews_index 'critiques', :controller => 'reviews', :action => 'user_index'
  end

  map.resource  :session, :account
end
