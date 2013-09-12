require 'spec_helper'

describe UsersController do

  let(:user_params) { FactoryGirl.attributes_for(:user, company_attributes: { name: 'company' }) }
  let(:invalid_params) { FactoryGirl.attributes_for(:user, email: '') }
  let(:user) { FactoryGirl.create(:user) }
  let(:invited_user) { FactoryGirl.create(:not_activated_user, invited: true) }
  let(:new_user) { FactoryGirl.create(:not_activated_user) }

  describe 'GET new' do
    before { xhr :get, :new }
    it { expect(assigns[:partner]).to_not be_nil }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before { xhr :post, :create, user: user_params }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(assigns[:success]).to be_true }
      it { expect(response).to render_template(:create) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.user.registration_mail_sent')) }
    end

    context 'with invalid params' do
      before { xhr :post, :create, user: invalid_params }
      it { expect(assigns[:success]).to be_false }
      it { expect(response).to render_template(:create) }
    end
  end

  describe 'GET edit' do
    context 'logged in' do
      before do
        controller.stub(:current_user).and_return(user)
        xhr :get, :edit, id: user
      end
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end

    context 'not logged in and invited' do
      before { get :edit, id: invited_user.token }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end

    context 'not logged in and not invited' do
      before { get :edit, id: new_user.token }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(response).to redirect_to(root_path) }
      it { expect(new_user.reload.token).to be_nil }
      it { expect(flash[:notice]).to eql(I18n.t('flash.user.registration_confirmed')) }
    end
  end

  describe 'PUT update' do
    context 'JS' do
      before { xhr :put, :update, id: user, user: user_params }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(assigns[:success]).to be_true }
      it { expect(response).to render_template(:update) }
    end

    context 'HTML with valid params' do
      before { put :update, id: new_user, user: user_params }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.user.registered')) }
      it { cookies[:auth_token].should be_eql(new_user.auth_token) }
    end

    context 'HTML with invalid params' do
      before { put :update, id: new_user, user: invalid_params }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(assigns[:success]).to be_false }
      it { expect(response).to render_template(:edit) }
    end

  end

end
