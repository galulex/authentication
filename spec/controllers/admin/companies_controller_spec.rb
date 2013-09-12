require 'spec_helper'

describe Admin::CompaniesController do

  let(:company) { FactoryGirl.create(:company, status: :published)}
  let(:partner) { FactoryGirl.create(:user, company: company)}
  let(:company_params) { FactoryGirl.attributes_for(:company, status: :draft)}
  let(:invalid_params) { FactoryGirl.attributes_for(:company, name: '', status: :draft)}

  before { controller.stub(:current_user).and_return(partner) }

  describe 'GET edit' do
    before { get :edit }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns[:company]).to_not be_nil }
  end

  describe 'PUT update' do
    context 'with valid params' do
      before { put :update, id: company, company: company_params }
      it { expect(assigns[:company]).to_not be_nil }
      it { expect(response).to redirect_to(admin_path) }
      it { expect(flash[:notice]).to eql(I18n.t('flash.company.submitted')) }
    end

    context 'with invalid params' do
      before { put :update, id: company, company: invalid_params }
      it { expect(assigns[:company]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end

    context 'save with valid params' do
      before { put :update, id: company, company: company_params, save: true }
      it { expect(assigns[:company]).to_not be_nil }
      it { expect(response).to render_template(:edit) }
    end
  end

end
