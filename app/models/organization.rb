class Organization < ActiveRecord::Base
  include Rakismet::Model

  rakismet_attrs :author => :name,
                 :author_email => :email,
                 :author_url => :website,
                 :content => :purpose

  has_many :reports

  before_create :generate_pin

  validates_presence_of :email, :name, :contact_person
  validates_format_of :email, :with => Validations::Email, :on => :create
  validates_uniqueness_of :email
  validates_format_of :website, :with => Validations::URL,
                                :unless => Proc.new { |record| record.website.blank? }

  def generate_pin
    if found = self.class.find(:last)
      self.pin = found.pin + 1
    else
      self.pin = 1001
    end
  end

end
