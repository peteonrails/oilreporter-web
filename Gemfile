source :gemcutter

group :rails do
  gem 'rails', '~> 2.3.5', :require => nil
  gem 'memcache-client', '>= 1.7.4', :require => nil
end

gem 'haml'
gem 'twitter'
gem 'RedCloth'
gem 'httparty'
gem 'mysql', '~> 2.8.1'
gem 'pg', '~> 0.9.0'
gem 'thin'
# gem 'libxml-ruby', '~> 1.1.3', :require => 'libxml'
gem 'aws-s3', '~> 0.6.2', :require => 'aws/s3'

group :plugins do
  gem 'paperclip', '~> 2.3.1'
  gem 'will_paginate', '~> 2.3'
end

group :development do
  gem 'sqlite3-ruby', '~> 1.2.5', :require => nil
  gem 'ruby-debug', '~> 0.10.3', :require => nil
end

# we don't call the group :test because we don't want them auto-required
group :testing do
  gem 'database_cleaner', '~> 0.5.0'
  gem 'rspec-rails', '~> 1.3.2', :require => 'spec/rails'
  gem 'factory_girl', '~> 1.2.3'
  gem 'pickle', '~> 0.2.1'
  gem 'cucumber-rails', '~> 0.3.0', :require => nil
  gem 'capybara', '~> 0.3.5'
end