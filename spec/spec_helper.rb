ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end

module AuthenticationHelper
  def stub_authentication
    @user_session = mock_model(UserSession, :user => Factory(:user))
    UserSession.stub!(:find).and_return(@user_session)
  end
end