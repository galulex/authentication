require 'spec_helper'

describe UsersController do

  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:user) { FactoryGirl.create(:user) }

  it 'should get new' do
    get :new
    response.should be_success
    flash.should be_blank
    assigns[:user].should_not be_nil
    response.should render_template :new
  end

  describe 'post create'
    it 'should create new user' do
      post :create, :user => user_params
      flash[:notice].should_not be_blank
      assigns[:user].should_not be_nil
      assigns[:user].errors.should be_blank
      response.should redirect_to root_path
    end

    it 'should not create new user' do
      user_params.delete(:email)
      post :create, :user => user_params
      flash.should be_blank
      assigns[:user].should_not be_nil
      assigns[:user].errors.should_not be_blank
      response.should render_template :new
    end

  describe 'get edit' do
    it 'should activate user' do
      get :edit, :id => user.token
      assigns[:user].should_not be_nil
      flash[:notice].should_not be_blank
      response.should redirect_to root_path
    end
    it 'should not activate user' do
      get :edit, :id => 0
      flash.should be_blank
      assigns[:user].should be_nil
      response.should redirect_to root_path
    end
  end

end
