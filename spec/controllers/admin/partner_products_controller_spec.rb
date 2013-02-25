require 'spec_helper'

describe Admin::PartnerProductsController do

  let(:company) { FactoryGirl.create(:company)}
  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:published_product) { FactoryGirl.create(:product, company: company, status: :published)}
  let(:pending_product) { FactoryGirl.create(:product, company: company, status: :pending)}
  let(:declined_product) { FactoryGirl.create(:product, company: company, status: :declined)}
  let(:product_params) { FactoryGirl.attributes_for(:product)}
  let(:invalid_params) { FactoryGirl.attributes_for(:product, name: '')}
  let(:admin) { FactoryGirl.create(:admin, company: company)}

  before { controller.stub!(:current_user).and_return(admin) }

  describe 'GET index' do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:products) }
  end

  describe 'GET edit' do
    before { get :edit, id: product }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should assign_to(:product) }
  end

  describe 'PUT update' do
    context 'save with valid params' do
      before { put :update, id: product, save: true }
      it { should render_template(:edit) }
    end

    context 'publish product draft with valid params' do
      before { put :update, id: product.instantiate_draft!, publish: true }
      it { should assign_to(:product) }
      it { should set_the_flash[:notice].to(I18n.t('flash.product.published')) }
      it { should redirect_to(admin_partner_products_path)  }
    end

    context 'publish product with valid params' do
      before { put :update, id: product, publish: true }
      it { should assign_to(:product) }
      it { should set_the_flash[:notice].to(I18n.t('flash.product.published')) }
      it { should redirect_to(admin_partner_products_path)  }
    end

    context 'preview with valid params' do
      before { put :update, id: product, preview: true }
      it { should render_template('products/show') }
      it { should render_with_layout('dashboard') }
    end

    context 'with invalid params' do
      before { put :update, id: product, product: invalid_params }
      it { should render_template(:edit) }
    end
  end

  describe 'GET show' do
    before { get :show, id: product }
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should assign_to(:product) }
  end

  describe 'DELETE destroy' do
    context 'pending' do
      before { xhr :delete, :destroy, id: pending_product, reason: 'reason' }
      it { should respond_with(:success) }
      it { should render_template(:destroy) }
      it { should set_the_flash[:notice].to(I18n.t('flash.product.declined')) }
    end

    context 'with invalid params' do
      before { xhr :delete, :destroy, id: pending_product }
      it { should render_template(:destroy) }
      it 'sets the flash' do
        expect(flash[:error]).to eql(I18n.t('flash.company.blank_reason'))
      end
    end

    context 'published' do
      before { xhr :delete, :destroy, id: published_product, reason: 'reason' }
      it { should respond_with(:success) }
      it { should render_template(:destroy) }
      it { should set_the_flash[:notice].to(I18n.t('flash.product.unpublished')) }
    end

  end
end
