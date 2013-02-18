require 'spec_helper'

describe UsersController do

  let(:user_params) { FactoryGirl.attributes_for(:user, company_attributes: { name: 'company' }) }
  let(:user) { FactoryGirl.create(:user) }
  let(:new_user) { FactoryGirl.create(:not_activated_user) }

  describe 'GET new' do
    before {xhr :get, :new }
    it { should assign_to(:partner) }
    it { should render_template(:new) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before {xhr :post, :create, user: user_params }
      it { should assign_to(:partner) }
      it { should render_template(:create) }
      it { should assign_to(:success).with(true) }
    end

    context 'with invalid params' do
      before {xhr :post, :create, user: {} }
      it { should render_template(:create) }
      it { should assign_to(:success).with(false) }
    end
  end
end