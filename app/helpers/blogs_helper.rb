module BlogsHelper
  def blog_check_box(group, blog)
    if blog == Blog.find_default_blog
      group.check_box blog.name.to_sym, :checked => true
    else
      group.check_box blog.name.to_sym, :checked => false
    end
  end
  
  def post_link(post, blog = nil, html_options = {})
    method = (html_options.delete(:url) == true ? "url" : "path")
    send "blog_post_#{method}", post.published_on.year, post.published_on.month, post.published_on.day, post.slug, {:blog => blog}.merge(html_options)
  end
  
  def blog_feedburner_url(blog)
    "http://feeds.feedburner.com/oilreporter#{"-#{blog.name}" unless blog.name == 'Oil Reporter'}"
  end
end