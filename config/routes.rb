ActionController::Routing::Routes.draw do |map|
  map.resources :sprockets, :only => [:index, :show]

  # Home
  map.root :controller => 'home'
  map.connect '/api/', :controller => 'home', :action => 'api'
  map.connect '/setup', :controller => 'home', :action => 'setup'
  map.connect '/tools', :controller => 'home', :action => 'tools'
  map.connect '/about', :controller => 'home', :action => 'about'

  # Reports
  map.resources :reports, :only => [:create, :update, :index, :map]
  map.connect '/map', :controller => 'reports', :action => 'map'
  map.data '/data', :controller => 'reports', :action => 'index'

  # Developers
  map.resources :developers, :only => [:new, :create, :show]
  map.connect '/signup', :controller => 'developers', :action => 'new'

  # Organizations
  map.resources :organizations, :only => [:index, :create, :new, :show]

end