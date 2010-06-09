require 'oil_spill'

class Report < ActiveRecord::Base
  belongs_to :developer
  belongs_to :organization
  has_many :report_metas

  validates_numericality_of :oil, :wetlands, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10
  validates_presence_of :latitude, :longitude
  validates_numericality_of :latitude, :longitude

  after_create :verify_location

  named_scope :within_oil_spill, :conditions => { :within_oil_spill => true }

  has_attached_file :media,
    :styles => { 
      :tiny  => "50x50#",
      :thumb  => "100x100#",
      :medium => "300x300>",
    },
    :path => Oilreporter.config.amazon_s3 ?
      ":attachment/:id/:style.:extension" :
      "public/system/:attachment/:id/:style/:basename.:extension"

  def verify_location
    self.update_attribute(:within_oil_spill, OilSpill.instance.contains?(self.latitude, self.longitude))
  end

  def hew
    fields = [:id, :oil, :wetlands, :wildlife, :description, :latitude, :longitude, :created_at]

    hash = self.attributes.symbolize_keys.inject({}) do |a, (k, v)|
      fields.include?(k) ? a.merge(k => v) : a
    end

    if self.media(:thumb) =~ /missing/
      hash.merge!(:media => nil)
    else
      hash.merge!(:media => { :tiny => self.media(:tiny),
                              :thumb => self.media(:thumb),
                              :medium => self.media(:medium) } )
    end
    
    [:latitude, :longitude].each do |k|
      hash[k] = "%.4f" % hash[k]
    end
    
    unless self.report_metas.empty?
      hash.merge!(:meta => self.report_metas.collect {|x| { x.key => x.value }})
    end

    hash
  end

  def self.per_page
    10
  end
end
