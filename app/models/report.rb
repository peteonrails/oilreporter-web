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

  def hew
    fields = [:id, :oil, :wildlife, :description, :media, :latitude, :longitude]

    hash = self.attributes.symbolize_keys.inject({}) do |a, (k, v)|
      fields.include?(k) ? a.merge(k => v) : a
    end

    if self.media(:thumb) =~ /missing/
      hash.merge!(:media => nil)
    else
      hash.merge!(:media => self.media(:thumb))
    end

    [:latitude, :longitude].each do |k|
      hash[k] = "%.4f" % hash[k]
    end

    hash
  end

  def self.per_page
    10
  end
end
