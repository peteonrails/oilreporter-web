require File.expand_path('../boot', __FILE__)
require 'oilreporter'

Bundler.require(:default, RAILS_ENV)

Oilreporter::Initializer.run do |config|

end

