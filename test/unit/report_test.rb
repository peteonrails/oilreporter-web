require File.join(File.dirname(__FILE__), '../test_helper')

class ReportTest < ActiveSupport::TestCase

  test 'valid report' do
    report = Factory.build(:new_orleans)
    assert report.save!
    assert report.reload.within_oil_spill?
  end

  test 'range must be between 1 and 10' do
    report = Factory.build(:new_orleans)
    report.oil = 11
    assert !report.valid?
  end

  test 'report must have latitude and longitude' do
    report = Factory.build(:new_orleans)
    report.latitude = report.longitude = nil
    assert !report.valid?
  end

  test 'valid report but not within oil spill boundary' do
    report = Factory.build(:washington_dc)
    assert report.save!
    assert !report.within_oil_spill?
    assert Report.within_oil_spill.empty?
  end

end
