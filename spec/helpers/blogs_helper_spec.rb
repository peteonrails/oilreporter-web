require File.dirname(__FILE__) + '/../spec_helper'

describe BlogsHelper do

  describe 'blog check_boxes' do
    before do
     Oilreporter.config[:default_blog] = 'default'
      @default_blog = Factory(:blog, :name => 'default')
      @regular_blog = Factory(:blog, :name => 'regular')
      @builder = ActionView::Helpers::FormBuilder.new(:blogs, nil, self, {}, nil)
    end

    it 'should generate a blog check box' do
      markup = helper.blog_check_box(@builder, @regular_blog)
      markup.should have_tag("input[type=checkbox]#blogs_#{@regular_blog.name}")
    end

    it 'should make the check_box checked if the default_blog is passed' do
      markup = helper.blog_check_box(@builder, @default_blog)
      markup.should have_tag("input[type=checkbox][checked=checked]#blogs_#{@default_blog.name}")
    end
  end
end