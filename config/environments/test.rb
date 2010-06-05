config.cache_classes = true
config.whiny_nils = true
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_loading            = true
config.action_controller.allow_forgery_protection    = false
config.action_mailer.delivery_method = :test

config.gem 'factory_girl', 
           :version => '>= 1.2.0'

HOST = 'localhost'

require 'factory_girl'

config.after_initialize do
  Disqus::defaults[:account] = "oilreporter"
end

  config.gem 'rspec-rails', :version => '>= 1.3.2', :lib => false unless File.directory?(File.join(Rails.root, 'vendor/plugins/rspec-rails'))
