require 'spec_helper'

describe NotificationsController do

  let(:company) { FactoryGirl.create(:company)}
  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:notification) { FactoryGirl.create(:notification, user: user, data: { company: company.name, product: product.name }) }

  before { controller.stub(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index }
    it { should render_template(:index) }
    it { should respond_with(:success) }
  end

  describe 'DELETE destroy' do
    context 'singilar notification' do
      before { xhr :delete, :destroy, id: notification }
      it { should respond_with(:success) }
      it { should render_template(:destroy) }
    end

    context 'all notifications' do
      before { delete :destroy, id: :all }
      it { should redirect_to(notifications_path)  }
      it 'delete all user notifications' do
        expect(user.notifications).to be_blank
      end
    end
  end
end
