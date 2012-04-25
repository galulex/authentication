require 'spec_helper'

describe PasswordResetsController do

  let(:user) { FactoryGirl.create(:user) }

  it 'should get new' do
    get :new
    response.should be_success
    flash.should be_blank
    response.should render_template :new
  end

  describe 'post create'
    it 'should create reset_password_token' do
      post :create, :email => user.email
      flash[:notice].should_not be_blank
      response.should redirect_to root_path
    end

    it 'should not create reset_password_token' do
      post :create, :email => ''
      flash[:error].should_not be_blank
      response.should render_template :new
    end

  describe 'get edit' do
    it 'should render edit page if token valid' do
      user.send_password_reset
      get :edit, :id => user.password_reset_token
      assigns[:user].should_not be_nil
      response.should render_template :edit
    end
    it 'should redirect to root path if token is expired' do
      user.send_password_reset
      user.update_attribute(:password_reset_sent_at, 3.days.ago)
      get :edit, :id => user.password_reset_token
      flash[:error].should_not be_blank
      assigns[:user].should_not be_nil
      response.should redirect_to root_path
    end
  end

end
