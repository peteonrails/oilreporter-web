ActionController::Routing::Routes.draw do |map|
  map.resources :sprockets, :only => [:index, :show]

  # Home
  map.root :controller => 'home'
  
  # Reports
  map.resources :reports, :only => [:create, :update, :index, :map]
  map.data '/data', :controller => 'reports', :action => 'index'
  map.connect '/map', :controller => 'reports', :action => 'map'
  map.localize '/localize', :controller => 'home', :action => 'localize'

  # Developers
  map.resources :developers, :only => [:new, :create, :show]
  map.connect '/signup', :controller => 'developers', :action => 'new'
  
  # API
  map.api '/api', :controller => 'api', :action => 'index'

  # Organizations
  map.resources :organizations, :only => [:index, :create]
  
end
