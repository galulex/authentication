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
    it { expect(assigns[:people]).to_not be_nil }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET new' do
    before { get :new }
    it { expect(assigns[:users]).to_not be_nil }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before { post :create , users: [user_params]}
      it { expect(flash[:notice]).to eql(I18n.t('flash.user.invite_sent')) }
      it { expect(assigns[:users]).to_not be_nil }
      it { expect(response).to redirect_to(invites_admin_people_path) }
    end

    context 'with invalid params' do
      before { post :create, users: [invalid_params] }
      it { expect(assigns[:users]).to_not be_nil }
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'GET invites' do
    before { get :invites }
    it { expect(assigns[:users]).to_not be_nil }
    it { expect(response).to render_template(:invites) }
  end

  describe 'PUT update' do
    before { xhr :put, :update, id: user, role_id: User::ROLES.index(User::EMPLOYEE) }
    it { expect(flash[:notice]).to eql(I18n.t('flash.user.role_updated')) }
    it { expect(user.reload.role_id).to eql(User::ROLES.index(User::EMPLOYEE)) }
  end

  describe 'DELETE destroy' do
    context 'activated users' do
      before { delete :destroy , id: user}
      it { expect(flash[:notice]).to eql(I18n.t('flash.user.deleted', name: user.name)) }
      it { expect(assigns[:user]).to_not be_nil }
      it { expect(response).to redirect_to(admin_people_path) }
    end

    context 'not activated users' do
      before { delete :destroy, id: new_user }
      it { expect(flash[:notice]).to eql(I18n.t('flash.user.invite_canceled')) }
      it { expect(response).to redirect_to(invites_admin_people_path) }
    end
  end
end
