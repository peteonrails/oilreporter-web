ActionController::Routing::Routes.draw do |map|

  # Home
  map.root :controller => 'home'
  
  # Reports
  map.resources :reports, :only => [:create, :update, :index]
  
  # Documentation
  map.resources :api, :only => [:create, :update, :index]
  
end
