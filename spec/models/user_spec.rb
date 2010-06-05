require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before do
    @user = Factory(:user, :login => 'oilreporter', :first_name => 'Oil', :last_name => 'Reporter', :title => 'Gulf Coast Cleanup Platform', :bio => "Oil Reporter was created by Intridea.")
  end

  it 'should have unique logins' do
    user2 = User.new(:login => 'oilreporter').should have(1).error_on(:login)
  end
  
  it "should be able to find a blog by it's name via from_param" do
    User.from_param(@user.login).should == @user
  end

  it "should be able to find a blog by it's id via from_param" do
    User.from_param(@user.id).should == @user
  end
  
  it '#to_param should be the login' do
    @user.to_param.should == 'oilreporter'
  end
  
  it '#bio_html should transform the bio field using Textile' do
    @user.bio = 'This is a *test* of\n\n "Textile":http://oilreporter.org'
    @user.bio_html.should == '<p>This is a <strong>test</strong> of\\n\\n <a href="http://oilreporter.org">Textile</a></p>'
  end
  
  it '#name should concatenate the first and last name sanely' do
    @user.name.should == 'Oil Reporter'
    @user.first_name = nil

    @user.name.should == 'Reporter'
    @user.last_name = nil

    @user.first_name = 'Oil'
    @user.name.should == 'Oil'
  end
  
  describe 'validations' do
    it "should validate twitter" do
      @user.twitter.should be_nil
      @user.should be_valid
      @user.twitter = '+-*/'
      @user.should_not be_valid
      @user.twitter = 'oil_reporter'
      @user.should be_valid
      @user.twitter = 'info@oilreporter.org'
      @user.should_not be_valid
      @user.twitter = 'www.oilreporter.org'
      @user.should_not be_valid
      @user.twitter = 'http://www.oilreporter.org'
      @user.should_not be_valid
    end

    it "should validate blog" do
      @user.blog.should be_nil
      @user.should be_valid
      @user.blog = '+-*/'
      @user.should_not be_valid
      @user.blog = 'oil_reporter'
      @user.should_not be_valid
      @user.blog = 'info@oilreporter.org'
      @user.should_not be_valid
      @user.blog = 'oilreporter.org'
      @user.should_not be_valid
      @user.blog = 'www.oilreporter.org'
      @user.should_not be_valid
      @user.blog = 'http://oilreporter.org'
      @user.should be_valid
      @user.blog = 'https://oilreporter.org'
      @user.should be_valid
      @user.blog = 'http://www.oilreporter.org'
      @user.should be_valid
      @user.blog = 'https://www.oilreporter.org'
      @user.should be_valid
    end

    it "should validate website" do
      @user.website.should be_nil
      @user.should be_valid
      @user.website = 'oilreporter.org'
      @user.should be_valid
      @user.website = 'www.oilreporter.org'
      @user.should be_valid
      @user.website = 'http://oilreporter.org'
      @user.should be_valid
      @user.website = 'https://oilreporter.org'
      @user.should be_valid
      @user.website = 'http://www.oilreporter.org'
      @user.should be_valid
      @user.website = 'https://www.oilreporter.org'
      @user.should be_valid
    end

  end

end