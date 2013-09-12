require 'spec_helper'

describe PasswordResetsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) {{ password: 'P@ssword', password_confirmation: 'P@ssword' }}
  let(:invalid_params) {{ password: 'P@ssword', password_confirmation: 'pass' }}

  describe 'GET new' do
    before { xhr :get, :new }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create'
    context 'with valid params' do
      before { xhr :post, :create, email: user.email }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:success]).to be_true }
      it { expect(flash[:notice]).to eql(I18n.t('flash.reset_password.email_sent')) }
    end

    context 'with invalid params' do
      before { xhr :post, :create, email: '' }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:success]).to be_false }
      it { expect(flash[:error]).to eql(I18n.t('flash.reset_password.email_blank')) }
    end

    context 'with not existing email' do
      before { xhr :post, :create, email: 'email' }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:success]).to be_false }
      it { expect(flash[:error]).to eql(I18n.t('flash.reset_password.user_does_not_exist')) }
    end


  describe 'GET edit' do
    context 'valid params' do
      before { user.reset_password; xhr :get, :edit, id: user.password_reset_token }
      it { expect(response).to render_template(:edit) }
    end

    context 'invalid params' do
      before do
        user.reset_password
        user.update_attribute(:password_reset_sent_at, 1.month.ago)
        xhr :get, :edit, id: user.password_reset_token
      end
      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:success]).to be_false }
      it { expect(flash[:error]).to eql(I18n.t('flash.reset_password.expired')) }
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before { user.reset_password; xhr :put, :update, id: user.password_reset_token, user: user_params }
      it { expect(response).to render_template(:update) }
      it { expect(assigns[:success]).to be_true }
      it { expect(flash[:notice]).to eql(I18n.t('flash.reset_password.done')) }
    end

    context 'with invalid params' do
      before { user.reset_password; xhr :put, :update, id: user.password_reset_token, user: invalid_params }
      it { expect(response).to render_template(:update) }
      it { expect(assigns[:success]).to be_false }
    end
  end

end
