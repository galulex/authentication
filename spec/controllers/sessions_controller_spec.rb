require 'spec_helper'

describe SessionsController do

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET new' do
    before { xhr :get, :new }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe 'POST create' do
    context 'valid params' do
      before { xhr :post, :create, email: user.email, password: user.password }
      it { should render_template(:create) }
      it 'should authorize user' do
        cookies[:auth_token].should be_eql(user.auth_token)
      end
    end

    context 'invalid params' do
      before { xhr :post, :create, email: user.email, password: '' }
      it { should render_template(:create) }
    end

    context 'not activated user' do
      before { user.update_attribute(:token, 'token'); xhr :post, :create, email: user.email, password: user.password }
      it { should render_template(:create) }
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy }
    it { should redirect_to(root_path)  }
    it { should set_the_flash[:notice] }
    it 'should destroy session' do
      cookies[:auth_token].should be_nil
    end
  end

end
