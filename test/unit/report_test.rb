require File.join(File.dirname(__FILE__), '../test_helper')

class ReportTest < ActiveSupport::TestCase

  def setup
    Factory.create(:louisiana)
  end

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

  test 'state is properly set' do
    report = Factory.create(:new_orleans)
    assert report.state == State.find_by_code('LA')
  end

  test 'slug is descriptive' do
    report = Factory.create(:new_orleans)
    assert !report.slug.blank?
    assert Regexp.new(report.description.split(' ').first, 'i') === report.slug
  end

  %w(washington_dc atlanta).each do |city|
    test "valid report but #{city} not within oil spill boundary" do
      report = Factory.build(city.to_sym)
      assert report.save!
      assert !report.within_oil_spill?
      assert Report.within_oil_spill.empty?
    end
  end

end
