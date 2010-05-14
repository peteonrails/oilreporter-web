require File.join(File.dirname(__FILE__), '../test_helper')

class DevelopersTest < ActionController::IntegrationTest

  test 'create developer' do
    developer = Factory.build(:dilbert).attributes

    post '/developers', :developer => developer
    assert_response :redirect
  end

  test 'creating a developer sends an email' do
    # Empty our outbox
    ActionMailer::Base.deliveries = [] 
    assert ActionMailer::Base.deliveries.empty?

    test_create_developer
    assert !ActionMailer::Base.deliveries.empty?
  end

  test 'create evil developer' do
    developer = Factory.build(:ratbert).attributes

    post '/developers', :developer => developer
    assert_response :success
    assert_template :new
  end

  test 'cannot create more than one developer with the same email' do
    test_create_developer

    developer = Factory.build(:dilbert).attributes

    post '/developers', :developer => developer
    assert_response :success
    assert_template :new
  end

end
