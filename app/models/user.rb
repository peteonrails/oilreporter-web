class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_list
  
  has_many :posts, :order => 'published_on DESC'
  has_attached_file :photo,
    :styles => { :thumb  => "80x80>" },
    :url  => "/photos/:id/:style/:basename.:extension",
    :path => Oilreporter.config.amazon_s3 ?
      "photos/:id/:style/:filename" :
      ":rails_root/photos/:id/:style/:filename",
    :default_url => "/images/missing.png"
  
  validates_attachment_size :photo, :less_than => APP_CONFIG['asset_max_file_size'].to_i.megabytes
  
  named_scope :listed, :conditions => "listed IS true"
  named_scope :unlisted, :conditions => "listed IS NOT true"
  named_scope :by_position, :order => :position
  named_scope :by_name, :order => "first_name ASC, last_name ASC, login ASC"
  
  before_destroy :reassign_posts

  validates_format_of :twitter, :with => /\A\w+\Z/, :message => "must be alphanumeric", :allow_blank => true
  validates_format_of :blog, :with => /\A(http)s?(:\/\/)/, :message => "must begin with http:// or https://", :allow_blank => true
  
  def self.from_param(parameter)
    find_by_login(parameter) || find_by_id(parameter)
  end
  
  def self.[](login_or_id)
    self.from_param(login_or_id)
  end
  
  def self.author_select_options
    by_name.collect{|u| [u.name, u.id]}
  end
  
  def name
    return login unless first_name? || last_name?
    "#{first_name}#{' ' if first_name? && last_name?}#{last_name}"
  end
  
  def to_param
    login
  end
    
  def bio_html
    RedCloth.new(bio.to_s).to_html
  end
  
  def self.generic
    User['admin']
  end
  
  protected
  
  def reassign_posts
    posts.each{ |p| p.update_attributes(:user_id => User.generic) }
  end
end