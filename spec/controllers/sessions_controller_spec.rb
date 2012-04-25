require 'spec_helper'

describe SessionsController do

  let(:user) { FactoryGirl.create(:user) }

  it 'should get new' do
    get :new
    response.should be_success
    flash.should be_blank
    response.should render_template :new
  end

  describe 'post create' do
    it 'should authorize user' do
      user.update_attribute(:token, nil)
      post :create, :email => user.email, :password => user.password
      cookies[:auth_token].should be_eql(user.auth_token)
      flash[:notice].should_not be_blank
      response.should redirect_to root_path
    end

    it 'should not authorize user with invalid credentials' do
      user.update_attribute(:token, nil)
      post :create, :email => user.email, :password => ''
      response.should render_template :new
      flash[:error].should_not be_blank
    end

    it 'should not authorize not activated user' do
      post :create, :email => user.email, :password => user.password
      response.should render_template :new
      flash[:error].should_not be_blank
    end
  end

  it 'should destroy session' do
    delete :destroy
    flash.should_not be_blank
    cookies[:auth_token].should be_nil
    response.should redirect_to root_path
  end

end
