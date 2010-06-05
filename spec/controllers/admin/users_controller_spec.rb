require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do
  include AuthenticationHelper
  
  describe 'new' do
    before(:each) do
      stub_authentication
    end
    
    it 'should instantiate a new user' do
      user = mock_model(User)
      User.should_receive(:new).and_return(user)
      get :new
    end

    it 'should render the correct template' do
      get :new
      response.should render_template(:new)
    end
  end

  describe 'show' do
    before do
      stub_authentication
    end
  end

  describe 'edit' do
    before do
      stub_authentication
    end
  end

  describe 'create' do
    before do
      stub_authentication
      @valid_user = mock_model(User)
      User.stub!(:new).and_return(@valid_user)
    end
  end
end