require File.join(File.dirname(__FILE__), '../test_helper')

class OrganizationsTest < ActionController::IntegrationTest

  test 'create organization' do
    organization = Factory.build(:shield).attributes

    post '/organizations', :organization => organization
    assert_response :redirect
    assert !flash[:info].empty?
    assert flash[:error].nil?
    assert_redirected_to :controller => 'home', :action => 'setup'
  end

  test 'creating a organization sends two emails' do
    # Empty our outbox
    ActionMailer::Base.deliveries = [] 
    assert ActionMailer::Base.deliveries.empty?

    test_create_organization
    assert !ActionMailer::Base.deliveries.empty?

    # One for the pin, one to notify us of a signup
    assert ActionMailer::Base.deliveries.count == 2
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

  test 'list organizations' do
    Factory.create(:shield)
    Factory.create(:super_friends)

    get '/organizations'
    assert_response :success
    assert_template :index
  end

  test 'list reports for an organization' do
    report = Factory.create(:new_orleans)
    report.organization = Factory.create(:shield)
    report.save!

    get "/organizations/#{report.organization.pin}?api_key=#{report.developer.api_key}"
    assert_response :success
    reports = JSON.parse(response.body)
    assert_equal reports.length, 1
    assert_equal reports.first['id'], report.id
  end

end
