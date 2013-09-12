require 'spec_helper'

describe SessionsController do

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET new' do
    before { xhr :get, :new }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    context 'valid params' do
      before { xhr :post, :create, email: user.email, password: user.password }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:success]).to be_true }
      it { expect(cookies[:auth_token]).to eql(user.auth_token) }
    end

    context 'invalid params' do
      before { xhr :post, :create, email: user.email, password: '' }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:error]).to eql(I18n.t('flash.user.invalid_email_or_password')) }
    end

    context 'not activated user' do
      before { user.update_attribute(:token, 'token'); xhr :post, :create, email: user.email, password: user.password }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:error]).to eql(I18n.t('flash.user.your_account_not_activated')) }
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy }
    it { expect(flash[:notice]).to eql(I18n.t('flash.user.logged_out')) }
    it { expect(response).to redirect_to(root_path) }
    it { expect(cookies[:auth_token]).to be_nil }
  end

end
