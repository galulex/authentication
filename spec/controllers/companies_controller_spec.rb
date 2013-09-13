require 'spec_helper'

describe CompaniesController do

  let(:company) { FactoryGirl.build(:company)}

  describe 'GET show' do
    before do
      company.stub(:to_param).and_return(:id)
      Company.stub(:find).and_return(company)
      get :show, id: company
    end
    it { expect(response).to render_template(:show) }
    it { expect(assigns[:company]).to_not be_nil }
  end
end
