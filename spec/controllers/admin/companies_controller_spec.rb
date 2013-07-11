require 'spec_helper'

describe Admin::CompaniesController do

  let(:company) { FactoryGirl.create(:company, status: :published)}
  let(:partner) { FactoryGirl.create(:user, company: company)}
  let(:company_params) { FactoryGirl.attributes_for(:company, status: :draft)}
  let(:invalid_params) { FactoryGirl.attributes_for(:company, name: '', status: :draft)}

  before { controller.stub(:current_user).and_return(partner) }

  describe 'GET edit' do
    before { get :edit }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
  end

  describe 'PUT update' do
    context 'with valid params' do
      before { put :update, id: company, company: company_params }
      it { should redirect_to(admin_path)  }
      it { should set_the_flash[:notice].to(I18n.t('flash.company.submitted')) }
    end

    context 'with invalid params' do
      before { put :update, id: company, company: invalid_params }
      it { should render_template(:edit) }
    end

    context 'save with valid params' do
      before { put :update, id: company, company: company_params, save: true }
      it { should render_template(:edit) }
    end
  end

end
