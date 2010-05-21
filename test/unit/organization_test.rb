require File.join(File.dirname(__FILE__), '../test_helper')

class OrganizationTest < ActiveSupport::TestCase

  test 'valid organization' do
    organization = Factory.build(:shield)
    assert organization.valid?
  end

  test 'organization receives pin after creation' do
    organization = Factory.build(:shield)
    assert organization.pin == nil
    organization.save!
    assert organization.reload.pin != nil
    assert /\d{4}/ === organization.pin.to_s
  end

  test 'pin increases in value' do
    shield = Factory.create(:shield)
    super_friends = Factory.create(:super_friends)
    assert (shield.pin + 1) == super_friends.pin
  end

end
