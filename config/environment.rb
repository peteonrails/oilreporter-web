require File.expand_path('../boot', __FILE__)
require 'oilreporter'

Bundler.require(:default, RAILS_ENV)

Oilreporter::Initializer.run do |config|
  config.load_paths << Rails.root
  
  config.after_initialize do
    SprocketsApplication.use_page_caching = !config.heroku?
    config.middleware.use "Rack::Honeypot"
  end
end

