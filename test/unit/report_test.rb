require File.join(File.dirname(__FILE__), '../test_helper')

class ReportTest < ActiveSupport::TestCase

  test 'valid report' do
    report = Factory.build(:new_orleans)
    assert report.valid?
  end

  test 'range must be between 1 and 10' do
    report = Factory.build(:new_orleans)
    report.oil = 11
    assert !report.valid?
  end

end
