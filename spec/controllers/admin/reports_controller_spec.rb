require 'spec_helper'

describe Admin::ReportsController do

  let(:admin) { FactoryGirl.create(:admin) }

  before { controller.stub(:current_user).and_return(admin) }

  describe 'GET index' do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe 'GET show' do
    context 'without filter' do
      before { get :show, id: :registration }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end

    context 'with date month filter' do
      before { get :show, id: :registration, filter: :month, date: { month: 1, year: 2012 } }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end

    context 'with date rage filter' do
      before { get :show, id: :registration, filter: :range, start: 1.day.ago }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end

    context 'with export option' do
      before { get :show, id: :registration, filter: :range, start: 1.day.ago, export: true }
      it 'sends data' do
        controller.expect(:send_data).with("csv").returns(:success)
      end
      it { should respond_with(:success) }
    end
  end
end
