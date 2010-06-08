ActionController::Routing::Routes.draw do |map|
  map.resources :sprockets, :only => [:index, :show]

  # Home
  map.root :controller => 'home'
  map.connect '/api/', :controller => 'home', :action => 'api'
  map.connect '/setup', :controller => 'home', :action => 'setup'
  map.connect '/tools', :controller => 'home', :action => 'tools'
  map.connect '/about', :controller => 'home', :action => 'about'
  map.connect '/privacy', :controller => 'home', :action => 'privacy'
  map.connect '/data-sources', :controller => 'home', :action => 'data_sources'
  map.connect '/tos', :controller => 'home', :action => 'tos'
  map.connect '/news', :controller => 'home', :action => 'news'

  # Reports
  map.resources :reports, :only => [:create, :update, :index, :map]
  map.connect '/map', :controller => 'reports', :action => 'map'
  map.data '/data', :controller => 'reports', :action => 'index'
  map.show_report '/reports/:state/:id', :controller => 'reports', :action => 'show', :requirements => { :state => /[a-z ]+/, :id => /[\w-]+/ }, :conditions => { :method => :get }

  # Developers
  map.resources :developers, :only => [:new, :create, :show]
  map.connect '/signup', :controller => 'developers', :action => 'new'

  # Organizations
  map.resources :organizations, :only => [:index, :create, :new, :show]
  
  # Admin
  map.resources :posts, :only => :show
  map.resource :user_session
  
  map.namespace :admin do |admin|
    admin.resources :posts
    admin.resources :users, :collection => {:update_positions => :put}
  end
  
  map.admin_home 'admin', :controller => 'admin/posts', :action => 'index'
  map.preview 'admin/post/preview', :controller => 'admin/posts', :action => 'preview'
  
  # Blog
  map.default_blog 'blog', :controller => 'blogs', :action => 'index'
  map.blog 'blog/:id', :controller => 'blogs', :action => 'show'
  map.blog_author 'blog/authors/:id', :controller => 'authors', :action => 'show'
  map.tag '/tag/:id', :controller => 'blogs', :action => 'tag'
  map.blog_post '/:year/:month/:day/:id', :controller => 'posts', :action => 'show', :requirements => {:month => /\d{1,2}/, :year => /\d{4}/, :day => /\d{1,2}/}
  map.default_blog_feed 'blog/feed.xml', :controller => 'blogs', :action => 'feed'
  map.blog_feed 'blog/:id/feed.xml', :controller => 'blogs', :action => 'feed'
  map.posts_by_year '/blog/archives/:year', :controller => 'posts', :action => 'index', :requirements => {:year => /\d{4}/}
  map.posts_by_month '/blog/archives/:year/:month', :controller => 'posts', :action => 'index', :requirements => {:month => /\d{1,2}/, :year => /\d{4}/}
  map.post_by_date '/blog/archives/:year/:month/:day', :controller => 'posts', :action => 'show', :requirements => {:month => /\d{1,2}/, :year => /\d{4}/}
  map.post_by_slug '/:year/:month/:day/:id', :controller => 'posts', :action => 'show', :requirements => {:month => /\d{1,2}/, :year => /\d{4}/}

end