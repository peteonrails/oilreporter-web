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

  test 'cannot create developer with extraordinarily long name or email' do
    data = (1..256).collect { 'a' }.join('')
    [:name, :email].each do |field|
      developer = Factory.build(:dilbert)
      assert developer.valid?
      value = field == :email ? "#{data}@test.com" : data
      developer.send("#{field}=", value)
      assert !developer.valid?
    end
  end

end
