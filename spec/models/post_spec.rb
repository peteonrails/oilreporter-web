require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  it 'should have recent posts' do
    4.times {Factory(:post, :created_at => (rand(6)+1).days.ago)}
    Post.recent.count.should == 4
  end

  it 'should have draft posts' do
    4.times {Factory(:post, :draft => true)}
    Post.drafts.count.should == 4
  end

  it 'should have published posts' do
    4.times {Factory(:post, :published_on => (rand(6)+1).days.ago)}
    Post.published.count.should == 4
  end

  it 'should only have non-draft posts in published posts' do
    4.times {Factory(:post, :published_on => (rand(6)+1).days.ago)}
    2.times {Factory(:post, :published_on => (rand(6)+1).days.ago, :draft => true)}
    Post.published.count.should == 4
  end

  it 'should create a slug on save' do
    post = Post.create(:title => 'oil spill')
    post.slug.should == 'oil-spill'
  end

  it 'should be able to accept custom slugs' do
    post = Post.create(:title => 'oil-spill', :slug => 'oil-spill-in-gulf-coast')
    post.slug.should == 'oil-spill-in-gulf-coast'
  end

  it 'should be able to lookup a post via slug' do
    post = Factory(:post, :title => 'do you see oil')
    Post.from_param(post.slug).should == post
  end

  it 'should be able to arrange posts by date' do
    post_first = Factory(:post, :title => 'test1', :published_on => 2.days.ago)
    post_last  = Factory(:post, :title => 'test2', :published_on => 3.days.ago)
    Post.published.by_date.first.should == post_first
  end

  it 'should be able to find posts within a specified year' do
    post_first = Factory(:post, :title => 'test1', :published_on => Time.parse('1/1/2009'))
    post_last  = Factory(:post, :title => 'test2', :published_on => Time.parse('1/1/2010'))
    Post.published.in_year('2009').should include(post_first)
  end

  it 'should be able to find posts within a specified month' do
    post_first = Factory(:post, :title => 'test1', :published_on => Time.parse('3/1/2010'))
    post_last  = Factory(:post, :title => 'test2', :published_on => Time.parse('1/1/2010'))
    Post.published.in_month('3').should include(post_first)
  end

  it 'should be able to find posts within a specified year and month' do
    post_first = Factory(:post, :title => 'test1', :published_on => Time.parse('3/1/2010'))
    post_last  = Factory(:post, :title => 'test2', :published_on => Time.parse('10/1/2010'))
    Post.published.in_year('2010').in_month('3').should_not include(post_last)
  end
end