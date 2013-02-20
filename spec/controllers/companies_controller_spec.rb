require 'spec_helper'

describe CompaniesController do

  let(:company) { FactoryGirl.create(:company)}

  describe 'GET show' do
    before { get :show, id: company }
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should assign_to(:company) }
  end
end