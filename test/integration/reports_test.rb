require File.join(File.dirname(__FILE__), '../test_helper')

class ReportsTest < ActionController::IntegrationTest

  test 'create report' do
    post_json '/reports', 
              :report => Factory.build(:new_orleans).attributes
    assert_response :success
  end

  test 'upload photo' do
    test_create_report
    report = Report.last
    assert !report.media?
    media = fixture_file_upload('media/1.jpg', 'image/jpeg')
    put "/reports/#{report.id}",
        :report => { :media => media }
    assert_response :success
    assert report.reload.media?
  end

  private

  def post_json(path, params)
    post path, params.to_json, {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  end

end
