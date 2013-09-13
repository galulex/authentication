require 'spec_helper'

describe AllLoginsController do

  let(:user) { FactoryGirl.build(:user)}

  before { User.any_instance.stub(:to_param).and_return(:id) }

  describe 'GET index' do
    context 'with char parameter' do
      before do
        user.stub(:where)
        user.company.stub(:users).and_return([user])
        companies = [user.company]
        companies.stub(:current_page).and_return(1)
        companies.stub(:total_pages).and_return(1)
        companies.stub(:limit_value).and_return(1)
        Company.stub_chain(:starts_with, :includes, :page, :per).and_return(companies)
        get :index, char: 'a'
      end
      it { expect(response).to render_template(:index) }
    end

    context 'without char parameter' do
      before { get :index  }
      it { expect(response).to render_template(:index) }
      it { expect(assigns[:companies]).to_not be_nil }
    end
  end

  describe 'GET show' do
    before do
      user.stub(:logins).and_return(double(create: true))
      User.stub(:find).and_return(user)
      get :show, id: user
    end
    it { should redirect_to(root_path)  }
    it { expect(cookies[:auth_token]).to eql(user.auth_token) }
  end
end
