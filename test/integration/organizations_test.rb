require File.join(File.dirname(__FILE__), '../test_helper')

class OrganizationsTest < ActionController::IntegrationTest

  test 'create organization' do
    organization = Factory.build(:shield).attributes

    post '/organizations', :organization => organization
    assert_response :redirect
    assert_redirected_to :controller => 'home', :action => 'setup'
  end

  test 'creating a organization sends an email' do
    # Empty our outbox
    ActionMailer::Base.deliveries = [] 
    assert ActionMailer::Base.deliveries.empty?

    test_create_organization
    assert !ActionMailer::Base.deliveries.empty?
  end

  test 'create evil organization' do
    organization = Factory.build(:legion_of_doom).attributes

    post '/organizations', :organization => organization
    assert_response :success
    assert_template :new
  end

  test 'cannot create more than one organization with the same email' do
    test_create_organization

    organization = Factory.build(:shield).attributes

    post '/organizations', :organization => organization
    assert_response :success
    assert_template :new
  end

end
