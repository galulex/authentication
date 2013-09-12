require 'spec_helper'

describe Admin::ReportsController do

  let(:admin) { FactoryGirl.create(:admin) }

  before { controller.stub(:current_user).and_return(admin) }

  describe 'GET index' do
    before { get :index }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET show' do
    context 'without filter' do
      before { get :show, id: :registration }
      it { expect(response).to render_template(:show) }
      it { expect(assigns[:report]).to_not be_nil }
    end

    context 'with date month filter' do
      before { get :show, id: :registration, filter: :month, date: { month: 1, year: 2012 } }
      it { expect(response).to render_template(:show) }
      it { expect(assigns[:report]).to_not be_nil }
    end

    context 'with date rage filter' do
      before { get :show, id: :registration, filter: :range, start: 1.day.ago }
      it { expect(response).to render_template(:show) }
      it { expect(assigns[:report]).to_not be_nil }
    end

    context 'with export option' do
      before { get :show, id: :registration, filter: :range, start: 1.day.ago, export: true }
      #it { controller.expect(:send_data).with("csv").returns(:success) }
      it { expect(response).to be_success }
    end
  end
end
