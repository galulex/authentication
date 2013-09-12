require 'spec_helper'

describe AllLoginsController do

  let(:user) { FactoryGirl.create(:user)}

  describe 'GET index' do
    context 'with char parameter' do
      before { get :index, char: 'a' }
      it { expect(response).to render_template(:index) }
    end

    context 'without char parameter' do
      before { get :index  }
      it { expect(response).to render_template(:index) }
      it { expect(assigns[:companies]).to_not be_nil }
    end
  end

  describe 'GET show' do
    before { get :show, id: user }
    it { should redirect_to(root_path)  }
    it { expect(cookies[:auth_token]).to eql(user.auth_token) }
  end
end
