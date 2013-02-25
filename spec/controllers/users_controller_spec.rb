require 'spec_helper'

describe UsersController do

  let(:user_params) { FactoryGirl.attributes_for(:user, company_attributes: { name: 'company' }) }
  let(:invalid_params) { FactoryGirl.attributes_for(:user, email: '') }
  let(:user) { FactoryGirl.create(:user) }
  let(:invited_user) { FactoryGirl.create(:not_activated_user, invited: true) }
  let(:new_user) { FactoryGirl.create(:not_activated_user) }

  describe 'GET new' do
    before { xhr :get, :new }
    it { should assign_to(:partner) }
    it { should render_template(:new) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before { xhr :post, :create, user: user_params }
      it { should assign_to(:partner) }
      it { should render_template(:create) }
      it { should set_the_flash[:notice].to(I18n.t('flash.user.registration_mail_sent')) }
      it { should assign_to(:success).with(true) }
    end

    context 'with invalid params' do
      before { xhr :post, :create, user: invalid_params }
      it { should render_template(:create) }
      it { should assign_to(:success).with(false) }
    end
  end

  describe 'GET edit' do
    context 'logged in' do
      before do
        controller.stub!(:current_user).and_return(user)
        xhr :get, :edit, id: user
      end
      it { should assign_to(:partner) }
      it { should render_template(:edit) }
    end

    context 'not logged in and invited' do
      before { get :edit, id: invited_user.token }
      it { should assign_to(:partner) }
      it { should render_template(:edit) }
    end

    context 'not logged in and not invited' do
      before { get :edit, id: new_user.token }
      it { should assign_to(:partner) }
      it { should set_the_flash[:notice].to(I18n.t('flash.user.registration_confirmed')) }
      it { should redirect_to(root_path)  }
      it 'activates a user' do
        expect(new_user.reload.token).to be_nil
      end
    end
  end

  describe 'PUT update' do
    context 'JS' do
      before { xhr :put, :update, id: user, user: user_params }
      it { should assign_to(:partner) }
      it { should assign_to(:success).with(true) }
      it { should render_template(:update) }
    end

    context 'HTML with valid params' do
      before { put :update, id: new_user, user: user_params }
      it { should assign_to(:partner) }
      it { should assign_to(:success).with(true) }
      it { should redirect_to(root_path)  }
      it { should set_the_flash[:notice].to(I18n.t('flash.user.registered')) }
      it 'should authorize user' do
        cookies[:auth_token].should be_eql(new_user.auth_token)
      end
    end

    context 'HTML with invalid params' do
      before { put :update, id: new_user, user: invalid_params }
      it { should assign_to(:partner) }
      it { should assign_to(:success).with(false) }
      it { should render_template(:edit) }
    end

  end

end
