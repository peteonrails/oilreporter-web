ActionController::Routing::Routes.draw do |map|

  # Home
  map.root :controller => 'home'
  
  # Reports
  map.resources :reports, :only => [:create, :update, :index]
  
  # Documentation
  map.api '/api', :controller => 'api', :action => 'index'
  
end
