require 'spec_helper'

describe Admin::ReportsController do

  let(:user) { FactoryGirl.create(:user)}

  describe 'GET index' do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe 'GET show' do
    #TO DO
  end
end