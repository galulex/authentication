require 'spec_helper'

describe AllLoginsController do

  let(:user) { FactoryGirl.create(:user)}

  describe 'GET index' do
    context 'with char parameter' do
      before { get :index, char: 'a' }
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end

    context 'without char parameter' do
      before { get :index  }
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end

  describe 'GET show' do
    before { get :show, id: user }
    it { should redirect_to(root_path)  }
    it 'should authorize user' do
      cookies[:auth_token].should be_eql(user.auth_token)
    end
  end
end
