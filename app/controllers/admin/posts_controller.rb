class Admin::PostsController < Admin::BaseController
  before_filter :find_blogs, :only => [:new, :edit]
  before_filter :post, :only => [:show, :edit, :update, :destroy]
  before_filter :include_syntax_highlighter

  def index
    add_crumb "posts", '/admin'
    @posts = Post.by_date.paginate( :page => params[:page], :per_page => 30 )
  end

  def preview
    @post = Post.new(params[:post])
    @preview = true
    render :action => 'show'
  end

  def show
    add_crumb "draft", "#{admin_post_url(@post)}"
  end

  def new
    add_crumb "new", '/admin/posts/new'
    @post = Post.new(:draft => true, :body_format => 'html', :published_on => Time.now, :user_id => current_user.id)
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      update_blog_publication(@post, params[:blogs])
      flash[:fancy] = "Post saved!"
      redirect_to admin_post_url(@post)
    else
      flash[:error] = "Post was not saved... something didn't work!"
      find_blogs
      render :action => :new
    end
  end

  def edit
    add_crumb "edit", "#{admin_post_url(@post)}"
  end

  def update
    if @post.update_attributes(params[:admin_post])
      update_blog_publication(@post, params[:blogs])
      flash[:fancy] = "Post updated!"
      redirect_to admin_post_path(@post)
    else
      flash[:error] = "Post was not updated... something didn't work!"
      find_blogs
      render :action => :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:fancy] = 'Post deleted sucessfully!'
      redirect_back_or_default admin_posts_url
    else
      flash[:error] = 'Post was not deleted. There was an issue.'
      redirect_back_or_default admin_post_url(@post)
    end
  end
  
  protected

  def update_blog_publication(post, blog_names)
    return if params[:blogs].blank?
    params[:blogs].each_pair do |key, value|
      blog = Blog.from_param(key)
      if value.to_i == 1 && !post.blogs.include?(blog)
        @post.blogs << blog
      end
      if value.to_i == 0 && post.blogs.include?(blog)
        @post.blogs.delete(blog)
      end
    end
  end

  def post
    @post ||= Post.from_param(params[:id])
  end

  def find_blogs
    @blogs = Blog.find(:all)
  end
  
  def blog
    @post ? @post.blog : nil
  end
  helper_method :blog, :post
end