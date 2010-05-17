class Organization < ActiveRecord::Base
  validates_presence_of :email, :name, :contact_person
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_format_of :website, :with => /\A(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?\Z/, 
                                :unless => Proc.new { |record| record.website.blank? }
end
