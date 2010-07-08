require File.join(File.dirname(__FILE__), '../test_helper')

class ReportSessionsTest < ActionController::IntegrationTest

  def setup
    Factory.create(:louisiana)
  end

  test 'create report session' do
    factory = Factory.build(:new_orleans)
    report_session = factory.attributes

    report_session.delete(:developer)
    report_session.merge!(:api_key => factory.developer.api_key)

    post '/reports', report_session
    assert_response :success
  end

  test 'add meta to report' do
    factory = Factory.build(:new_orleans)
    
    ReportSession.create
    report_session = ReportSession.last
    developer = Developer.last
    
    put "/report_sessions/#{report_session.id}", { :api_key => factory.developer.api_key, :meta => meta_values }
            
    assert_response :success
    assert !report_session.session_metas.empty?
    assert_equal report_session.session_metas.length, 4
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
