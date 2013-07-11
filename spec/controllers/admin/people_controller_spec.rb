require 'spec_helper'

describe Admin::PeopleController do

  let(:company) { FactoryGirl.create(:company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:new_user) { FactoryGirl.reload; FactoryGirl.create(:not_activated_user, company: company)}
  let(:user_params) { FactoryGirl.reload; FactoryGirl.attributes_for(:user)}
  let(:invalid_params) { FactoryGirl.attributes_for(:user, email: '')}

  before { controller.stub(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe 'GET new' do
    before { get :new }
    it { should render_template(:new) }
    it { should respond_with(:success) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before { post :create , users: [user_params]}
      it { should set_the_flash[:notice].to(I18n.t('flash.user.invite_sent')) }
      it { should redirect_to(invites_admin_people_path)  }
    end

    context 'with invalid params' do
      before { post :create, users: [invalid_params] }
      it { should render_template(:new) }
    end
  end

  describe 'GET invites' do
    before { get :invites }
    it { should respond_with(:success) }
    it { should render_template(:invites) }
  end

  describe 'PUT update' do
    before { xhr :put, :update, id: user, role_id: User::ROLES.invert[User::EMPLOYEE] }
    it 'sets the flash' do
      expect(flash[:notice]).to eql(I18n.t('flash.user.role_updated'))
    end
    it 'updates user role' do
      expect(user.reload.role_id).to eql(User::ROLES.invert[User::EMPLOYEE])
    end
  end

  describe 'DELETE destroy' do
    context 'activated users' do
      before { delete :destroy , id: user}
      it { should set_the_flash[:notice].to(I18n.t('flash.user.deleted', name: user.name)) }
      it { should redirect_to(admin_people_path)  }
    end

    context 'not activated users' do
      before { delete :destroy, id: new_user }
      it { should set_the_flash[:notice].to(I18n.t('flash.user.invite_canceled')) }
      it { should redirect_to(invites_admin_people_path)  }
    end
  end
end
