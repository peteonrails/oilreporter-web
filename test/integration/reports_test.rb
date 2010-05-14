require File.join(File.dirname(__FILE__), '../test_helper')

class ReportsTest < ActionController::IntegrationTest

  def setup
    @developer = Factory.create(:dilbert)
  end

  test 'create report' do
    report = Factory.build(:new_orleans).attributes
    report.delete(:developer)
    report.merge!(:api_key => @developer.api_key)

    post_json '/reports', report
    assert_response :success
  end

  test 'upload photo' do
    test_create_report
    report = Report.last
    assert !report.media?
    media = fixture_file_upload('media/1.jpg', 'image/jpeg')

    put "/reports/#{report.id}", { :media => media, :api_key => @developer.api_key }
    assert_response :success
    assert report.reload.media?
  end

  test 'list reports in json' do
    test_create_report
    report = Report.first

    get "/reports.json", { :api_key => @developer.api_key }
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

end
