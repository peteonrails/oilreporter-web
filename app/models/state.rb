require 'geocode'

class State < ActiveRecord::Base
  extend Geocode

  has_many :reports

  validates_presence_of :name, :code

  after_create :sluggify

  def self.reverse_geocode(lat, lng)
    return State.find_by_code('LA') if RAILS_ENV == 'test'
    return nil if lat.nil? or lng.nil?
    code = state(lat, lng)
    return State.find_by_code('XX') unless code
    return self.find_by_code(code)
  end

  def sluggify
    self.update_attribute(:slug, self.name.downcase.gsub(/\s/, '-'))
  end

end
