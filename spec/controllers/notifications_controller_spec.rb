require 'spec_helper'

describe NotificationsController do

  let(:company) { FactoryGirl.create(:company)}
  let(:product) { FactoryGirl.create(:product, company: company)}
  let(:user) { FactoryGirl.create(:user, company: company)}
  let(:notification) { FactoryGirl.create(:notification, user: user, data: { company: company.name, product: product.name }) }

  before { controller.stub(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index }
    it { expect(response).to render_template(:index) }
    it { expect(assigns[:notifications]).to_not be_nil }
  end

  describe 'DELETE destroy' do
    context 'singilar notification' do
      before { xhr :delete, :destroy, id: notification }
      it { expect(response).to render_template(:destroy) }
      it { expect(assigns[:notification]).to_not be_nil }
    end

    context 'all notifications' do
      before { delete :destroy, id: :all }
      it { expect(response).to redirect_to(notifications_path) }
      it { expect(user.notifications).to be_blank }
    end
  end
end
