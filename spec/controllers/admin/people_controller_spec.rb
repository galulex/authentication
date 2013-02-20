require 'spec_helper'

describe Admin::PeopleController do

  let(:company) { FactoryGirl.create(:company)}
  let(:partner) { FactoryGirl.create(:user, company: company)}

  before { controller.stub!(:current_user).and_return(partner) }

  describe 'GET index' do
    before { get :index, id: partner }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:people) }
  end

end
