require File.expand_path('../boot', __FILE__)
require 'oilreporter'

Bundler.require(:default, RAILS_ENV)

Oilreporter::Initializer.run do |config|
  config.load_paths << Rails.root
  
  config.after_initialize do
    SprocketsApplication.use_page_caching = !config.heroku?
    ENV['RECAPTCHA_PUBLIC_KEY']  = '6LcKeboSAAAAAJsQQRps1Fck8BVJfm9eipjILh_0'
    ENV['RECAPTCHA_PRIVATE_KEY'] = '6LcKeboSAAAAAMh0MxWpoCzGPMVVN-8YGZrq7Y80'
    Haml::Template.options[:ugly] = true
  end

end
