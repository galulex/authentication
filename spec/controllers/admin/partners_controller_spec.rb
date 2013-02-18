require 'spec_helper'

describe Admin::PartnersController do

  let(:company) { FactoryGirl.create(:company, status: 'published')}
  let(:company_draft) { FactoryGirl.create(:company_draft, company: company, status: 'pending')}
  let(:partner) { FactoryGirl.create(:user, company: company)}
  let(:user_params) { FactoryGirl.attributes_for(:user)}
  let(:company_params) { FactoryGirl.attributes_for(:company, status: 'draft')}

  describe 'GET index' do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:companies) }
  end

  describe 'GET new' do
    before { get :new }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should assign_to(:partner) }
  end

  describe 'GET show' do
    before { xhr :get, :show, id: partner.company }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before { post :create, user: user_params }
      it { should set_the_flash[:notice].to(I18n.t('flash.partner.created')) }
      it { should redirect_to(admin_partners_path)  }
      it { should assign_to(:partner) }
    end

    context 'with invalid params' do
      before { post :create, user: user_params.merge!(email: nil) }
      it { should render_template(:new) }
      it { should assign_to(:partner) }
    end
  end


  describe 'GET edit' do
    before { get :edit, id: company }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should assign_to(:company) }
  end

  describe 'PUT update' do
    context 'save with valid params' do
      before { put :update, id: company, company: company_params, save: true }
      it { should set_the_flash[:notice].to(I18n.t('flash.company.saved')) }
      it { should render_template(:edit) }
      it { should assign_to(:company) }
    end

    context 'submit with valid params' do
      before { put :update, id: company, company: company_params }
      it { should set_the_flash[:notice].to(I18n.t('flash.company.submitted')) }
      it { should redirect_to(admin_partners_path)  }
      it { should assign_to(:company) }
    end

    context 'with invalid params' do
      before { put :update, id: company, company: company_params.merge!(name: '') }
      it { should render_template(:edit) }
      it { should assign_to(:company) }
    end
  end


  describe 'DELETE destroy' do
    before { xhr :delete, :destroy, id: company_draft }
    it { should respond_with(:success) }
    it { should render_template(:destroy) }
    it { should assign_to(:company) }
  end


end
