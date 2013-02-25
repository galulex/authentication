require 'spec_helper'

describe PasswordResetsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) {{ password: 'P@ssword', password_confirmation: 'P@ssword' }}
  let(:invalid_params) {{ password: 'P@ssword', password_confirmation: 'pass' }}

  describe 'GET new' do
    before { xhr :get, :new }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe 'POST create'
    context 'with valid params' do
      before { xhr :post, :create, email: user.email }
      it { should render_template(:create) }
      it { should assign_to(:success).with(true) }
      it { should set_the_flash[:notice].to(I18n.t('flash.reset_password.email_sent')) }
    end

    context 'with invalid params' do
      before { xhr :post, :create, email: '' }
      it 'sets the flash' do
        flash[:error].should eql(I18n.t('flash.reset_password.email_blank'))
      end
      it { should render_template(:create) }
    end

    context 'with not existing email' do
      before { xhr :post, :create, email: 'email' }
      it 'sets the flash' do
        flash[:error].should eql(I18n.t('flash.reset_password.user_does_not_exist'))
      end
      it { should render_template(:create) }
    end


  describe 'GET edit' do
    context 'valid params' do
      before { user.reset_password; xhr :get, :edit, id: user.password_reset_token }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
      it { should assign_to(:user).with(user) }
    end

    context 'invalid params' do
      before do
        user.reset_password
        user.update_attribute(:password_reset_sent_at, 1.month.ago)
        xhr :get, :edit, id: user.password_reset_token
      end
      it { should render_template(:edit) }
      it { should set_the_flash[:error].to(I18n.t('flash.reset_password.expired')) }
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before { user.reset_password; xhr :put, :update, id: user.password_reset_token, user: user_params }
      it { should render_template(:update) }
      it { should assign_to(:success).with(true) }
      it { should set_the_flash[:notice].to(I18n.t('flash.reset_password.done')) }
    end

    context 'with invalid params' do
      before { user.reset_password; xhr :put, :update, id: user.password_reset_token, user: invalid_params }
      it { should assign_to(:success).with(false) }
      it { should render_template(:update) }
    end
  end

end
