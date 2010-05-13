ActionController::Routing::Routes.draw do |map|

  # Home
  map.root :controller => 'home'
  
  # Reports
  map.resources :reports, :only => [:create, :update, :index, :map]
  map.data '/data', :controller => 'reports', :action => 'index'
  map.connect '/map', :controller => 'reports', :action => 'map'

  # Developers
  map.resources :developers, :only => [:new, :create]
  map.connect '/signup', :controller => 'developers', :action => 'new'

  # Documentation
  map.api '/api', :controller => 'api', :action => 'index'
  
end
