require File.join(File.dirname(__FILE__), '../test_helper')

class DeveloperTest < ActiveSupport::TestCase

  test 'valid developer' do
    developer = Factory.build(:dilbert)
    assert developer.valid?
  end

  test 'evil developer with no email' do
    developer = Factory.build(:ratbert)
    assert !developer.valid?
  end

  test 'success generates api key' do
    developer = Factory.build(:dilbert)
    assert developer.api_key.blank?
    developer.save!
    assert /[\d\w]{40}/ === developer.reload.api_key
  end

end
