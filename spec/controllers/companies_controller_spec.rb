require 'spec_helper'

describe CompaniesController do

  let(:company) { FactoryGirl.create(:company)}

  describe 'GET show' do
    before { get :show, id: company }
    it { expect(response).to render_template(:show) }
    it { expect(assigns[:company]).to_not be_nil }
  end
end
