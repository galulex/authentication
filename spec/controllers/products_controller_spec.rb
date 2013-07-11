require 'spec_helper'

describe ProductsController do

  let(:company) { FactoryGirl.create(:company) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:product) { FactoryGirl.create(:product, company: company) }

  before { controller.stub(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe 'GET show' do
    before { get :show, id: product }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe 'PUT update' do
    before { xhr :put, :update, id: product, score: 1 }
    it { should respond_with(:success) }
    it { should render_template(:update) }
    it 'rates the product' do
      expect(product.ratings).to_not be_blank
    end
  end

end
