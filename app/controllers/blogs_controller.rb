class BlogsController < ApplicationController
  before_filter :include_syntax_highlighter

  def index
    add_crumb "blog", '/blog'
    @blog = Blog.find_default_blog
    @posts = Post.published.by_date.paginate( :page => params[:page] )
    render :action => 'show'
  end

  def show
    @blog = Blog.from_param(params[:id])
    @posts = Post.published.by_date.paginate( :page => params[:page] )
  end

  def tag
    @tag = params[:id]
    @posts = Post.published.by_date.find_tagged_with(params[:id])
  end
  
  # blog/feed.xml
  def feed
    @blog = params[:id] ? Blog.from_param(params[:id]) : Blog.find_default_blog
    @posts = Post.published.by_date.limit(20)
    render :layout => false # feed.rxml
  end
  
  protected
  
  def blog
    @blog ||= Blog.from_param(params[:id]) || Blog.from_param(params[:blog])
  end
  
  helper_method :blog
end