module PostsHelper
  def render_body(post)
    if post.body_format == 'textile'
      RedCloth.new(post.body).to_html
    elsif post.body_format == 'markdown'
      BlueCloth.new(post.body).to_html
    else
      post.body
    end
  end
  
  def future_draft(post)
    klass = []
    klass << 'future' if post.published_on > Date.today
    klass << 'draft' if post.draft?
    return klass.join(' ')
  end

  def tag_links_for(tags)
    tags.collect{|tag| link_to tag, tag_url(tag) }.join(" ")
  end
end