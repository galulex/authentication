require 'spec_helper'

describe Admin::PeopleController do

  let(:company) { FactoryGirl.create(:company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:invalid_params) { FactoryGirl.attributes_for(:user, company: '')}
  let(:user_params) { FactoryGirl.attributes_for(:user)}

  before { controller.stub!(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index, id: partner }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:people) }
  end

  describe 'GET new' do
    before { get :new }
    it { should assign_to(:users) }
    it { should render_template(:new) }
    it { should respond_with(:success) }
  end

  describe 'POST create' do
    context 'company valid' do
      before { post :create , user: user_params}
      it { should assign_to(:users) }
      it { should respond_with(:success) }
      it { should set_the_flash[:notice].to(I18n.t('flash.user.invite_sent')) }
      it { should redirect_to(invites_admin_people_path)  }
    end

    context 'company invalid' do
      before { post :create, company: invalid_params }
      it { should assign_to(:users) }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end


end
