require 'spec_helper'

describe Admin::ProductsController do

  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:company) { FactoryGirl.create(:company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:published_product) { FactoryGirl.create(:product, status: :published)}
  let(:pending_product) { FactoryGirl.create(:product, status: :pending)}
  let(:product_params) { FactoryGirl.attributes_for(:product) }
  let(:invalid_params) { FactoryGirl.attributes_for(:product, name: '')}


  before { controller.stub!(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index, id: product }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:products) }
  end

  describe 'GET new' do
    before { get :new }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should assign_to(:product) }
  end

  describe 'POST create' do
    context 'save with valid params' do
      before { post :create, product: product_params, save: true}
      it { should render_template(:edit)}
      it { should assign_to(:product) }
    end

    context 'submit with valid params' do
      before { post :create, product: product_params, submit: true}
      it { should assign_to(:product) }
      it { should redirect_to(admin_products_path)  }
      it { should set_the_flash[:notice].to(I18n.t('flash.product.submitted')) }
    end

    context 'with invalid params' do
      before { post :create, product: invalid_params}
      it { should render_template(:new) }
      it { should assign_to(:product) }
    end
  end

  describe 'GET show' do
    before { get :show, id: product }
    it { should respond_with(:success) }
    it { should assign_to(:product) }
    it { should render_template('products/show') }
    it { should render_with_layout('dashboard') }
  end

  describe 'GET edit' do
    context 'pending product' do
      before { get :edit, id: pending_product }
      it { should redirect_to(admin_products_path)  }
      #it { should set_the_flash[:alert].to(I18n.t('flash.product.pending')) }
    end

    context 'not pending product' do
      before { get :edit, id: published_product }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
    end
  end

  describe 'PUT update' do
    context 'save with valid params' do
      before { put :update, id: product, product: product_params, save: true }
      it { should render_template(:edit) }
    end

    context 'submit with valid params' do
      before { put :update, id: product, product: product_params, submit: true }
      it { should set_the_flash[:notice].to(I18n.t('flash.product.submitted')) }
      it { should redirect_to(admin_products_path)  }
    end

    context 'with invalid params' do
      before { put :update, id: product, product: invalid_params }
      it { should render_template(:edit) }
    end
  end

  describe 'DELETE destroy' do
    context 'product' do
      before { delete :destroy, id: product }
      it { should assign_to(:product) }
      it { should redirect_to(admin_products_path)  }
    end

    context 'published product' do
      before { delete :destroy, id: published_product }
      #TO DO
    end
  end
end