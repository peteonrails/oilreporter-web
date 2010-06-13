module BlogsHelper
  def blog_check_box(group, blog)
    if blog == Blog.find_default_blog
      group.check_box blog.name.to_sym, :checked => true
    else
      group.check_box blog.name.to_sym, :checked => false
    end
  end
  
  def blog_feedburner_url(blog)
    "http://feeds.feedburner.com/oilreporter#{"-#{blog.name}" unless blog.name == 'Oil Reporter'}"
  end
end