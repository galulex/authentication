require 'spec_helper'

describe NotificationsController do

  let(:company) { FactoryGirl.build(:company)}
  let(:product) { FactoryGirl.build(:product, company: company)}
  let(:user) { FactoryGirl.build(:user, company: company)}
  let(:notification) { FactoryGirl.build(:notification, user: user, data: { company: company.name, product: product.name }) }

  before do
    notification.stub(:to_param).and_return(:id)
    notification.stub(:created_at).and_return(Time.now)
    user.stub(:to_param).and_return(:id)
    user.stub_chain(:notifications, :order, :to_a).and_return([notification])
    user.stub_chain(:notifications, :unread, :update_all).and_return(true)
    user.stub_chain(:notifications, :unread, :count).and_return(1)
    controller.stub(:current_user).and_return(user)
  end

  describe 'GET index' do
    before { get :index }
    it { expect(response).to render_template(:index) }
    it { expect(assigns[:notifications]).to_not be_nil }
  end

  describe 'DELETE destroy' do
    context 'singilar notification' do
      before do
        user.stub_chain(:notifications, :find).and_return(notification)
        notification.should_receive(:delete)
        xhr :delete, :destroy, id: notification
      end
      it { expect(response).to render_template(:destroy) }
      it { expect(assigns[:notification]).to_not be_nil }
    end

    context 'all notifications' do
      before do
        user.stub_chain(:notifications, :delete_all)
        delete :destroy, id: :all
      end
      it { expect(response).to redirect_to(notifications_path) }
    end
  end
end
