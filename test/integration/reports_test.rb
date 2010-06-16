require File.join(File.dirname(__FILE__), '../test_helper')

class ReportsTest < ActionController::IntegrationTest

  def setup
    Factory.create(:louisiana)
  end

  test 'create report' do
    factory = Factory.build(:new_orleans)
    report = factory.attributes

    report.delete(:developer)
    report.merge!(:api_key => factory.developer.api_key)

    post '/reports', report
    assert_response :success

    report = Report.last
    get "/reports/#{report.state.name.downcase}/#{report.slug}"
    assert_response :success
    assert_template :show
  end

  test 'create report for organization' do
    factory = Factory.build(:new_orleans)
    developer = factory.developer
    organization = Factory.create(:shield)
    report = factory.attributes

    report.delete(:developer)
    report.merge!(:api_key => developer.api_key)
    report.merge!(:organization_pin => organization.pin)

    post '/reports', report
    assert_response :success
    assert Report.last.organization == organization
    assert organization.reload.reports.include?(Report.last)
  end

  test 'create report with bad organization pin' do
    factory = Factory.build(:new_orleans)
    developer = factory.developer
    report = factory.attributes

    report.delete(:developer)
    report.merge!(:api_key => developer.api_key)
    report.merge!(:organization_pin => 0000)

    # We do not throw an error if the organization pin is invalid
    post '/reports', report
    assert_response :success
  end

  test 'create report with a report session' do
    factory = Factory.build(:new_orleans)
    developer = factory.developer
    report = factory.attributes
    report_session = ReportSession.create
    
    report.delete(:developer)
    report.merge!(:api_key => developer.api_key)
    report.merge!(:report_session_id => report_session.id)

    post '/reports', report
    assert_response :success
    assert Report.last.report_session == report_session
    assert report_session.reload.reports.include?(Report.last)
  end
  
  test 'upload photo' do
    test_create_report
    report = Report.last
    developer = Developer.last
    assert !report.media?
    media = fixture_file_upload('media/1.jpg', 'image/jpeg')

    put "/reports/#{report.id}", { :api_key => developer.api_key, :media => media, :api_key => report.developer.api_key }
    assert_response :success
    assert report.reload.media?
  end

  test 'add meta to report' do
    test_create_report
    report = Report.last
    developer = Developer.last
    
    put "/reports/#{report.id}", { :api_key => developer.api_key, :meta => meta_values }
            
    assert_response :success
    assert !report.report_metas.empty?
    assert_equal report.report_metas.length, 4
  end

  test 'list reports in json' do
    test_create_report
    report = Report.last
        
    ReportMeta.create_from_params(report, meta_values)

    get "/reports.json", { :api_key => report.developer.api_key }
    assert_response :success
    reports = JSON.parse(response.body)
    assert_equal reports.length, 1
    assert_equal reports.first['id'], report.id
  end

  test 'list reports in json sans api key' do
    get "/reports.json", { :api_key => 'gobbledygook' }
    assert_response :unprocessable_entity
    msg = JSON.parse(response.body)
    assert msg['error']
  end

  test 'list reports in json with session id' do
    report_session = ReportSession.create
    test_create_report(:report_session_id => report_session.id)
    report = Report.last
    developer = Developer.last

    get "/report_sessions/#{report_session.id}/reports.json", { :api_key => developer.api_key }

    assert_response :success
    reports = JSON.parse(response.body)
    
    assert_equal reports.length, 1
    assert_equal reports.first['id'], report.id
    assert_equal reports.first['session_id'], report_session.id
  end
  
  test 'list reports in html' do
    test_create_report
    report = Report.first

    get "/reports"
    assert_response :success
  end

  private

  def post_json(path, params)
    post path, params.to_json, {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  end

  def meta_values
    { 
      'key1' => 'value1', 
      'key2' => 'value2',
      'key3' => 'value3', 
      'key4' => 'value4' 
    }
  end
end
