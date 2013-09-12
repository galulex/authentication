require 'spec_helper'

describe Admin::PartnersController do

  let(:company) { FactoryGirl.create(:company, status: 'published')}
  let(:company_draft) { company.instantiate_draft! }
  let(:admin) { FactoryGirl.create(:admin, company: company)}
  let(:partner) { FactoryGirl.reload; FactoryGirl.create(:user, company: company)}
  let(:user_params) { FactoryGirl.reload; FactoryGirl.attributes_for(:user)}
  let(:company_params) { FactoryGirl.attributes_for(:company, status: 'draft')}

  before { controller.stub(:current_user).and_return(admin) }

  describe 'GET index' do
    before { get :index }
    it { expect(assigns[:companies]).to_not be_nil }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET new' do
    before { get :new }
    it { expect(assigns[:partner]).to_not be_nil }
    it { expect(response).to render_template(:new) }
  end

  describe 'GET show' do
    before { xhr :get, :show, id: partner.company }
    it { expect(assigns[:company]).to_not be_nil }
    it { expect(response).to render_template(:show) }
  end

  describe 'POST create' do
    context 'with valid params' do
      before { post :create, user: user_params }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(response).to redirect_to(admin_partners_path) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.partner.created')) }
    end

    context 'with invalid params' do
      before { post :create, user: user_params.merge!(email: nil) }
      it { expect(assigns[:partner]).to_not be_nil }
      it { expect(response).to render_template(:new) }
    end
  end


  describe 'GET edit' do
    before { get :edit, id: company }
    it { expect(assigns[:company]).to_not be_nil }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PUT update' do
    context 'save with valid params' do
      before { put :update, id: company, company: company_params, save: true }
      it { expect(assigns[:company]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.company.saved')) }
    end

    context 'submit with valid params' do
      before { put :update, id: company, company: company_params }
      it { expect(assigns[:company]).to_not be_nil }
      it { expect(response).to redirect_to(admin_partners_path) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.company.published')) }
    end

    context 'with invalid params' do
      before { put :update, id: company, company: company_params.merge!(name: '') }
      it { expect(assigns[:company]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end
  end


  describe 'DELETE destroy' do
    context 'with valid params' do
      before do
        company_draft.submit!
        xhr :delete, :destroy, id: company_draft, reason: 'reason'
      end
      it { expect(assigns[:success]).to be_true }
      it { expect(response).to render_template(:destroy) }
    end
    context 'with invalid params' do
      before { xhr :delete, :destroy, id: company, reason: '' }
      it { expect(response).to render_template(:destroy) }
      it { expect(flash[:error]).to eql(I18n.t('flash.company.blank_reason')) }
    end
  end

end
