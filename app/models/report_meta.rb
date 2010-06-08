class ReportMeta < ActiveRecord::Base
  belongs_to :report
    
  def as_json
    { "#{key}" => "#{value}" }
  end
  
  def self.create_from_params(report, params)
    params.each_pair do |key, val|
      self.create(:report_id => report.id, :key => key, :value => val)
    end
  end
end