require 'digest/sha1'

class Developer < ActiveRecord::Base
  has_many :reports

  after_create :generate_api_key

  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates_length_of :email, :name, :maximum => 255
  validates_format_of :email, :with => Validations::Email, :on => :create
  validates_format_of :website, :with => Validations::URL,
                                :unless => Proc.new { |record| record.website.blank? }

  def generate_api_key
    srand
    update_attribute(:api_key, Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[0..40])
  end
end
