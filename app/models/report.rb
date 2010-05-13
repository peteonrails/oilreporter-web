class Report < ActiveRecord::Base
  validates_numericality_of :oil, :wetlands, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10
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

  def jsonify
    fields = [:oil, :wildlife, :media, :latitude, :longitude, :description]

    object = self.attributes.symbolize_keys.inject({}) do |a, (k, v)|
      fields.include?(k) ? a.merge(k => v) : a
    end

    if self.media(:thumb) =~ /missing/
      object.merge!(:media => nil)
    else
      object.merge!(:media => self.media(:thumb))
    end

    object.to_json
  end

  def self.per_page
    10
  end
end
