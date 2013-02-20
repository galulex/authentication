require 'spec_helper'

describe AllLoginsController do

  let(:user) { FactoryGirl.create(:user)}

  describe 'GET index' do
    before { get :index  }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:companies) }
  end

  describe 'GET show' do
    before { get :show, id: user }
    it { should redirect_to(root_path)  }
  end
end