require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
  include AuthenticationHelper

  describe 'new' do
    it 'should instantiate a new UserSession' do
      get :new
      assigns(:user_session).should_not be_nil
    end

    it 'should render the appropriate template' do
      get :new
      response.should render_template(:new)
    end
  end

  describe 'create' do
    before do
      @session = mock_model(UserSession)
      UserSession.stub!(:new).and_return(@session)
    end

    it 'should redirect with a flash notice upon successful save' do
      @session.stub!(:save).and_return(true)
      post :create
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_home_url)
    end

    it 'should render new template with a flash error upon failed save' do
      @session.stub!(:save).and_return(false)
      post :create
      flash[:error].should_not be_nil
      response.should render_template('new')
    end
  end

  describe 'destroy' do
    it 'should end the current user session and redirect with a flash message' do
      stub_authentication
      # user_session found in spec_helper
      @user_session.stub!(:destroy).and_return(true)
      post :destroy
      flash[:notice].should_not be_nil
      response.should be_redirect
    end   
  end
end