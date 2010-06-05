require File.dirname(__FILE__) + '/../spec_helper'

describe BlogsController do
  describe 'routes' do
    it 'should recognise index' do
      params_from(:get, '/blog').should == {:controller => 'blogs', :action => 'index'}
    end

    it 'should recognise show with id' do
      params_from(:get, "/blog/oilreporter").should == {:controller => 'blogs', :action => 'show', :id => 'oilreporter'}
    end

  end

  describe 'show' do
    it 'should find a blog' do
      blog = Blog.create(:name => 'oilreporter')
      get :show, :id => 'oilreporter'
      assigns(:blog).should == blog
    end
  end

  describe 'index' do
    it 'should find the intridea blog' do
      Oilreporter.config[:default_blog] = 'intridea'
      intridea_blog = Blog.create(:name => 'intridea')
      get :index
      assigns(:blog).should == intridea_blog
    end
  end
end
