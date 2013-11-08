require 'spec_helper'

describe Admin::PartnerProductsController do

  let(:company) { FactoryGirl.create(:company)}
  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:product_draft) { FactoryGirl.create(:product_draft, product: product) }
  let(:published_product) { FactoryGirl.create(:product, company: company, status: :published)}
  let(:pending_product) { FactoryGirl.create(:product, company: company, status: :pending)}
  let(:declined_product) { FactoryGirl.create(:product, company: company, status: :declined)}
  let(:product_params) { FactoryGirl.attributes_for(:product)}
  let(:invalid_params) { FactoryGirl.attributes_for(:product, name: '')}
  let(:admin) { FactoryGirl.create(:admin, company: company)}

  before { controller.stub(:current_user).and_return(admin) }

  describe 'GET index' do
    before { get :index }
    it { expect(assigns[:products]).to_not be_nil }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET edit' do
    before { get :edit, id: product }
    it { expect(assigns[:product]).to_not be_nil }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PUT update' do
    context 'save with valid params' do
      before { put :update, id: product, save: true }
      it { expect(response).to render_template(:edit) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.saved')) }
    end

    context 'publish product draft with valid params' do
      before { put :update, id: product_draft, publish: true }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.published')) }
      it { expect(response).to redirect_to(admin_partner_products_path) }
    end

    context 'publish product with valid params' do
      before { put :update, id: product, publish: true }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.published')) }
      it { expect(response).to redirect_to(admin_partner_products_path) }
    end

    context 'preview with valid params' do
      before { put :update, id: product, preview: true }
      it { expect(response).to render_template('products/show') }
    end

    context 'with invalid params' do
      before { put :update, id: product, product: invalid_params }
      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:product]).to_not be_nil }
    end
  end

  describe 'GET show' do
    before { get :show, id: product }
    it { expect(response).to render_template(:show) }
    it { expect(assigns[:product]).to_not be_nil }
  end

  describe 'DELETE destroy' do
    context 'pending' do
      before { xhr :delete, :destroy, id: pending_product, reason: 'reason' }
      it { expect(response).to render_template(:destroy) }
      it { expect(assigns[:product]).to_not be_nil }
      it { expect(assigns[:success]).to be_true }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.declined')) }
    end

    context 'with invalid params' do
      before { xhr :delete, :destroy, id: pending_product }
      it { expect(response).to render_template(:destroy) }
      it { expect(flash[:error]).to eql(I18n.t('flash.company.blank_reason')) }
    end

    context 'published' do
      before { xhr :delete, :destroy, id: published_product, reason: 'reason' }
      it { expect(response).to render_template(:destroy) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.unpublished')) }
    end

  end
end
