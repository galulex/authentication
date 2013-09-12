require 'spec_helper'

describe ProductReviewsController do

  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:company) { FactoryGirl.create(:company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:product_review) { FactoryGirl.create(:product_review, product: product, user: user)}
  let(:review_params) { FactoryGirl.attributes_for(:product_review) }
  let(:invalid_params) { FactoryGirl.attributes_for(:product_review, review: '')}

  before { controller.stub(:current_user).and_return(user) }

  describe 'GET new' do
    before { xhr :get, :new, product_id: product }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    context 'save with valid params' do
      before { xhr :post, :create, product_id: product, product_review: review_params }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:success]).to be_true }
      it { expect(assigns[:review]).to_not be_nil }
    end

    context 'save with invalid params' do
      before { xhr :post, :create, product_id: product, product_review: invalid_params }
      it { expect(response).to render_template(:create) }
      it { expect(assigns[:success]).to be_false }
    end
  end

  describe 'GET edit' do
    before { xhr :get, :edit, product_id: product, id: product_review }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PUT update' do
    before { xhr :put, :update, product_id: product, id: product_review, product_review: review_params }
    it { expect(response).to render_template(:update) }
    it { expect(assigns[:success]).to be_true }
  end

  describe 'DELETE destroy' do
    before { xhr :delete, :destroy, product_id: product, id: product_review }
    it { expect(response).to render_template(:destroy) }
  end
end
