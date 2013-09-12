require 'spec_helper'

describe ProductsController do

  let(:company) { FactoryGirl.create(:company) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:product) { FactoryGirl.create(:product, company: company) }

  before { controller.stub(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index }
    it { expect(assigns[:search]).to_not be_nil }
    it { expect(assigns[:products]).to_not be_nil }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET show' do
    before { get :show, id: product }
    it { expect(assigns[:product]).to_not be_nil }
    it { expect(response).to render_template(:show) }
  end

  describe 'PUT update' do
    before { xhr :put, :update, id: product, score: 1 }
    it { expect(assigns[:product]).to_not be_nil }
    it { expect(response).to render_template(:update) }
    it { expect(product.ratings).to_not be_blank }
  end

end
