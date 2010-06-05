class Post < ActiveRecord::Base
  acts_as_taggable_on :tags

  has_many :postings
  has_many :blogs, :through => :postings
  belongs_to :user

  validates_presence_of :title, :slug
  before_validation_on_create :set_slug

  named_scope :drafts, :conditions => { :draft => true }
  named_scope :published, lambda {{ :conditions => ['draft = false AND published_on < ?', DateTime.now ]}}
  named_scope :recent, lambda {{ :conditions => ['created_at > ?', 1.week.ago] }}
  named_scope :limit, lambda {|l| {:limit => l}}

  named_scope :by_date, :order => 'published_on DESC'
  named_scope :featured, :conditions => ["featured = ?",true]
  named_scope :in_year, lambda{|year| {:conditions => ["extract(YEAR FROM published_on) = ?",year]}}
  named_scope :in_month, lambda{|month| 
   if month.is_a?(Month)
     {:conditions => ["extract(MONTH FROM published_on) = ? AND extract(YEAR FROM published_on) = ?", month.month, month.year]}
   else
     {:conditions => ["extract(MONTH FROM published_on) = ?", month]}
   end
  }
  
  # will_paginate
  cattr_reader :per_page
  @@per_page = 15

  def atomid
    atomid || generated_atomid
  end

  def generated_atomid
    "tag:oilreporter.org,#{published_on.to_date.to_s :db}:#{id}"
  end

  def blog
    blogs.not_default.first || blogs.first || Blog.find_default_blog
  end
  
  def to_param
    slug
  end

  def set_slug
    return if title.blank? && slug.blank?
    self.slug = title.downcase.gsub(" ","-").gsub(/[^a-z0-9-]/,"") if slug.blank?
  end

  def self.tags
    find(:all).collect{|post| post.tag_list}.flatten
  end

  def self.from_param(parameter)
    find_by_slug(parameter) || find_by_id(parameter)
  end
end
