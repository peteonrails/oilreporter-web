require File.dirname(__FILE__) + '/../spec_helper'

describe PostsHelper do
  describe 'body_format' do
    it 'should render RedCloth (Textile)' do
      post = Factory(:post, :body => 'h1. Title', :body_format => 'textile')
      helper.render_body(post).should == '<h1>Title</h1>'
    end

    it 'should render BlueCloth (Markdown)' do
      post = Factory(:post, :body => '# Title', :body_format => 'markdown')
      helper.render_body(post).should == '<h1>Title</h1>'
    end

    it 'should render HTML' do
      post = Factory(:post, :body => '<h1>Title</h1>', :body_format => 'html')
      helper.render_body(post).should == '<h1>Title</h1>'
    end
  end

  it 'should create links for tags' do
    tags = ['oil', 'spill', 'bp']
    helper.tag_links_for(tags).should == "<a href=\"http://test.host/tag/oil\">oil</a> <a href=\"http://test.host/tag/spill\">spill</a> <a href=\"http://test.host/tag/bp\">bp</a>"
  end
end