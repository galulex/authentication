require 'spec_helper'

describe Admin::ProductsController do

  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:company) { FactoryGirl.create(:company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:published_product) { FactoryGirl.create(:product, company: company, status: :published)}
  let(:pending_product) { FactoryGirl.create(:product, company: company, status: :pending)}
  let(:product_params) { FactoryGirl.attributes_for(:product) }
  let(:invalid_params) { FactoryGirl.attributes_for(:product, name: '')}


  before { controller.stub(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index, id: product }
    it { expect(assigns[:products]).to_not be_nil }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET new' do
    before { get :new }
    it { expect(assigns[:product]).to_not be_nil }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    context 'save with valid params' do
      before { post :create, product: product_params, save: true}
      it { expect(assigns[:product]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end

    context 'submit with valid params' do
      before { post :create, product: product_params, submit: true}
      it { expect(response).to redirect_to(admin_products_path) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.submitted')) }
    end

    context 'with invalid params' do
      before { post :create, product: invalid_params}
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'GET show' do
    before { get :show, id: product }
    it { expect(assigns[:product]).to_not be_nil }
    it { expect(response).to render_template('products/show') }
  end

  describe 'GET edit' do
    context 'pending product' do
      before { get :edit, id: pending_product }
      it { expect(response).to redirect_to(admin_products_path) }
      it { expect(flash[:alert]).to eql(I18n.t('flash.product.pending')) }
    end

    context 'not pending product' do
      before { get :edit, id: published_product }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe 'PUT update' do
    context 'save with valid params' do
      before { put :update, id: product, product: product_params, save: true }
      it { expect(assigns[:product]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end

    context 'submit with valid params' do
      before { put :update, id: product, product: product_params }
      it { expect(assigns[:product]).to_not be_nil }
      it { expect(response).to redirect_to(admin_products_path) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.product.submitted')) }
    end

    context 'with invalid params' do
      before { put :update, id: product, product: invalid_params }
      it { expect(assigns[:product]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, id: published_product }
    it { expect(response).to redirect_to(admin_products_path) }
    it { expect(published_product.reload).to be_retracted }
  end
end
