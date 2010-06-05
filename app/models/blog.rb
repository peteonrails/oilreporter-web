class Blog < ActiveRecord::Base
  has_many :postings
  has_many :posts, :through => :postings
  validates_uniqueness_of :name

  named_scope :not_default, lambda { { :conditions => ["name != ?", Blog.find_default_blog.name] } }
  
  def to_param
    name
  end
  
  def title
    name.titleize
  end
  
  def self.from_param(parameter)
    find_by_name(parameter) || find_by_id(parameter)
  end
  
  def self.[](name)
    from_param(name)
  end

  def self.find_default_blog
    find_by_name(Oilreporter.config[:default_blog].downcase)
  end
end
