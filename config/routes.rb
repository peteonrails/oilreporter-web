ActionController::Routing::Routes.draw do |map|

  # Home
  map.root :controller => 'home'
  map.api '/api', :controller => 'home', :action => 'api'
  map.favicon '*favicon.ico'
  
  # Reports
  map.resources :reports, :only => [:create, :update, :index, :map]
  map.data '/data', :controller => 'reports', :action => 'index'
  map.connect '/map', :controller => 'reports', :action => 'map'

  # Developers
  map.resources :developers, :only => [:new, :create, :show]
  map.connect '/signup', :controller => 'developers', :action => 'new'
  
end
