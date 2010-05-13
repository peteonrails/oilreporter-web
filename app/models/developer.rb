require 'digest/sha1'

class Developer < ActiveRecord::Base
  after_create :generate_api_key

  validates_presence_of :email, :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_format_of :website, :with => /\A(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?\Z/, 
                                :unless => Proc.new { |record| record.website.blank? }

  def generate_api_key
    srand
    update_attribute(:api_key, Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[0..40])
  end
end
