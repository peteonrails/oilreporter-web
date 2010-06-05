require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PostsController do
  include AuthenticationHelper

  describe 'preview' do
    before do
      stub_authentication
    end

    it 'should render the show template' do
      post :preview, :post => {:title => 'test'}
      response.should render_template('show')
    end

    it 'should instantiate a post object' do
      post :preview, :post => {:body => 'test'}
      assigns(:post).body.should == 'test'
    end

    it 'should not create a new post in the db' do
      lambda {
        post :preview, :post => {:title => 'test'}
      }.should_not change(Post, :count)
    end

    it "should indicate that it's a preview (for parials)" do
      post :preview, :post => {:title => 'test'}
      assigns(:preview).should == true
    end
  end

  describe 'index authentication' do
    it "should disallow unauthenticated users" do
      get :index
      response.should redirect_to(new_user_session_path)
    end

    it "should allow authenticated users" do
      stub_authentication
      get :index
      response.should_not be_redirect
    end
  end

  describe 'index' do

    before do
      stub_authentication
    end

    it 'should find recent posts' do
      4.times {Factory(:post)}
      get :index
      assigns(:posts).should == Post.recent
    end

    it 'should render the correct template' do
      get :index
      response.should render_template(:index)
    end
  end

  describe 'new authentication' do
    it "should disallow unauthenticated users" do
      get :new
      response.should redirect_to(new_user_session_path)
    end

    it "should allow authenticated users" do
      stub_authentication
      get :new
      response.should_not be_redirect
    end
  end

  describe 'new' do
    before do
      stub_authentication
    end

    it 'should instantiate a new post' do
      get :new
      assigns(:post).should_not be_nil
    end

    it 'should have a list of blogs' do
      4.times {Factory(:blog)}
      get :new
      assigns(:blogs).size.should == 4
    end

    it 'should render the correct template' do
      get :new
      response.should render_template(:new)
    end
  end

  describe 'show authentication' do
    before do
      Post.stub!(:find)
    end
  end

  describe 'show' do
    before do
      stub_authentication
      @existing_post = Factory(:post)
    end

    it 'should find a post' do
      get :show, :id => @existing_post.id
      assigns(:post).should == @existing_post
    end

    it 'should render the correct template' do
      get :show, :id => @existing_post.id
      response.should render_template(:show)
    end
  end

  describe 'create authentication' do
    it "should disallow unauthenticated users" do
      post :create, :post => {:title => 'happy'}
      response.should redirect_to(new_user_session_path)
    end

    it "should allow authenticated users" do
      stub_authentication
      post :create, :post => {:title => 'happy'}
      response.should_not redirect_to(new_user_session_path)
    end
  end

  describe 'create' do
    before do
      stub_authentication
    end

    it 'should create a new post' do
      Factory(:blog, :name => 'test_blog')
      lambda {
        post :create, :post => {:title => 'test_blog'}
      }.should change(Post, :count)
    end

    it 'should be able to add a blog to the post' do
      blog = Factory(:blog, :name => 'test_blog')
      post :create, :post => {:title => 'happy'}, :blogs => {:test_blog => '1'}
      Post.find_by_title('happy').blogs.should include(blog)
    end

    it 'should add a save a body format (textile/html/etc)' do
      post :create, :post => {:title => 'happy', :body_format => 'textile'}
      Post.find_by_title('happy').body_format.should == 'textile'
    end

    describe 'saving' do
      before do
        @valid_post = mock_model(Post)
        Post.stub!(:new).and_return(@valid_post)
      end

      it 'should render new template with a flash error upon failed save' do
        @valid_post.stub!(:save).and_return(false)
        controller.stub!(:update_blog_publication).and_return(false)
        post :create
        flash[:error].should_not be_nil
        response.should render_template('new')
      end
    end
  end

  describe 'edit authentication' do
    before do
      Post.stub!(:find)
    end
  end

  describe 'edit' do
    before do
      stub_authentication
    end

    it 'should find an existing post to update' do
      existing_post = Factory(:post)
      get :edit, :id => existing_post.id
      assigns(:post).should == existing_post
    end
  end

  describe 'update authentication' do
    before do
      mock_post = mock_model(Post)
      mock_post.stub!(:update_attributes)
      Post.stub!(:find).and_return(mock_post)
    end
  end

  describe 'update' do
    before do
      stub_authentication
      @existing_post = Factory(:post)
    end

    it 'should find a post to update' do
      put :update, :id => @existing_post.id
      assigns(:post).should == @existing_post
    end

    it 'should update a post' do
      put :update, :id => @existing_post.id, :admin_post => {:title => 'updated_post'}
      Post.find(@existing_post.id).title.should == 'updated_post'
    end

    it 'should add blog publications' do
      blog = Factory(:blog, :name => 'intridea')
      put :update, :id => @existing_post.id, :blogs => {blog.name.to_sym => '1'}
      Post.find(@existing_post.id).blogs.should include(blog)
    end

    it 'should remove blog publications' do
      blog = Factory(:blog, :name => 'intridea')
      @existing_post.blogs << blog
      @existing_post.save
      put :update, :id => @existing_post.id, :blogs => {blog.name.to_sym => '0'}
      Post.find(@existing_post.id).blogs.should_not include(blog)
    end

    it 'should add a save a body format (textile/html/etc)' do
      put :update, :id => @existing_post.id, :admin_post => {:body_format => 'textile'}
      Post.find(@existing_post.id).body_format.should == 'textile'
    end

    describe 'updating' do
      before do
        @valid_post = mock_model(Post)
        Post.stub!(:find).and_return(@valid_post)
      end
    end
  end
end