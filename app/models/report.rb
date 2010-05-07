class Report < ActiveRecord::Base
  validates_numericality_of :oil, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10
  has_attached_file :media,
    :styles => {
      :tiny  => "50x50#",
      :thumb  => "100x100#",
      :medium => "300x300>",
    },
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'oilreporter_production'
end
