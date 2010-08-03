require 'oil_spill'

class Report < ActiveRecord::Base
  belongs_to :developer
  belongs_to :organization
  belongs_to :report_session
  has_many :report_metas

  validates_numericality_of :oil, :wetlands, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10
  validates_presence_of :latitude, :longitude
  validates_numericality_of :latitude, :longitude

  after_create :verify_location
  after_create :sluggify

  named_scope :within_oil_spill, :conditions => { :within_oil_spill => true }

  belongs_to :state

  has_attached_file :media,
    :styles => { 
      :tiny  => "50x50#",
      :thumb  => "100x100#",
      :medium => "300x300>",
    },
    :path => Oilreporter.config.amazon_s3 ?
      ":attachment/:id/:style.:extension" :
      "public/system/:attachment/:id/:style/:basename.:extension",
    :default_url => "http://oilspill_photos.s3.amazonaws.com/missing.png"

  validates_attachment_size :media, :less_than => Oilreporter.config.asset_max_file_size.to_i.megabytes, :unless => lambda { |record| record.media_content_type.blank? }

  def verify_location
    self.update_attribute(:within_oil_spill, OilSpill.instance.contains?(self.latitude, self.longitude))
  end

  def sluggify
    state_id = nil
    state = State.reverse_geocode(self.latitude, self.longitude)
    if state
      self.update_attribute(:state_id, state.id)
      state_id = state.id
    end

    slug = description.downcase.gsub(/'s/, '').gsub(/[^[:alnum:]\-\s\_]/, '').split(/[\s\-\_]+/).delete_if { |i| i.empty? }
    limit_reached = false
    slug = slug.inject('') do |str, token|
      new_token = str.length == 0 ? token : "-#{token}"
      limit_reached = true if (str.length + new_token.length) > 50
      limit_reached ? str : str << new_token
    end

    slug = "oil-report" if slug.blank?
    slug += "-#{self.class.last.id + 1}" if self.class.find(:first, :conditions => { :slug => slug, :state_id => state_id })
    self.update_attribute(:slug, slug)
  end

  def hew
    fields = [:id, :oil, :wetlands, :wildlife, :description, :latitude, :longitude, :report_session_id, :created_at]

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
  
  def to_param
    slug
  end
end
