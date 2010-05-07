ActionController::Routing::Routes.draw do |map|

  map.resources :reports, :only => [:create, :update, :index]

  # Home
  map.root :controller => 'home'

end
