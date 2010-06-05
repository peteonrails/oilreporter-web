require File.dirname(__FILE__) + '/../spec_helper'

describe Blog do
  it 'should have a unique name' do
    Blog.create(:name => 'non-unique')
    Blog.new(:name => 'non-unique').should have(1).error_on(:name)
  end

  it "should be able to find a blog by it's name via from_param" do
    blog = Blog.create(:name => 'intridea')
    Blog.from_param(blog.name).should == blog
  end

  it "should be able to find a blog by it's id via from_param" do
    blog = Blog.create(:name => 'intridea')
    Blog.from_param(blog.id).should == blog
  end

  it 'should have a default blog' do
    Oilreporter.config[:default_blog] = 'default'
    blog = Blog.create(:name => 'default')
    Blog.find_default_blog.should == blog
  end
end
