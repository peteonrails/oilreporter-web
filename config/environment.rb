require File.expand_path('../boot', __FILE__)
require 'oilreporter'

Bundler.require(:default, RAILS_ENV)

Oilreporter::Initializer.run do |config|
  config.load_paths << Rails.root
  
  config.after_initialize do
    SprocketsApplication.use_page_caching = !config.heroku?
    config.middleware.use Rack::Recaptcha, :public_key => '6LcKeboSAAAAAJsQQRps1Fck8BVJfm9eipjILh_0',
                                           :private_key => '6LcKeboSAAAAAMh0MxWpoCzGPMVVN-8YGZrq7Y80',
                                           :paths => ['/signup', '/organizations/new', '/developers/new']
  end

end
