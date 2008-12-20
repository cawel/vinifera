ActionController::Routing::Routes.draw do |map|
  
  map.resources :ratings
  
  map.resources :varieties

  map.resources :colors, :active_scaffold => true
  
  map.resources :wines, :active_scaffold => true do |wine|
    wine.resources :reviews, :active_scaffold => true
  end
  
  #  map.connect '/wines/review', :controller => 'wines', :action => 'write_review'
  
  map.root                   :controller => 'wines', :action => 'list'
  
  map.login     '/login',    :controller => 'sessions',    :action => 'new'
  map.logout    '/logout',   :controller => 'sessions',    :action => 'destroy'
  
  map.register  '/register', :controller => 'people',     :action => 'create'
  map.signup    '/signup',   :controller => 'people',     :action => 'new'
  
  map.reset_password '/reset_password', :controller => 'password_resets', :action => 'new',    :conditions => {:method => :get}
  map.reset_password '/reset_password', :controller => 'password_resets', :action => 'create', :conditions => {:method => :post}
  
  map.connect '/account', :controller => 'accounts', :action => 'edit'
  
  map.resources :people
  map.resource  :session, :account
end
