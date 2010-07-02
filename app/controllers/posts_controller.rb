class PostsController < ApplicationController
  include ApplicationHelper
  
  before_filter :include_syntax_highlighter

  def index
    @posts = Post.published.by_date
    if params[:year]
      @posts = @posts.in_year(params[:year].to_i)
    end

    if params[:month]
      @posts = @posts.in_month(params[:month].to_i)
    end
  end

  def show
    add_crumb "#{post.title.downcase}", "#{post_link(post)}"
    canonical_url post_link(post)
  end
    
  protected
  
  def post
    Post.from_param(params[:id])
  end
  
  def blog
    @blog ||= Blog.from_param(params[:blog_id]) || Blog.from_param(params[:blog]) || post.blog || Blog.find_default_blog
  end
  
  helper_method :post, :blog
end