require 'spec_helper'

describe AdminsController do

  let(:admin) { FactoryGirl.build(:admin)}

  describe 'GET show' do
    context 'authentacated user' do
      before do
        controller.stub(:current_user).and_return(admin)
        admin.stub(:to_param).and_return(:id)
        get :show
      end
      it { expect(response).to render_template(:show) }
    end

    context 'not authentacated user' do
      before { get :show  }
      it { expect(response).to redirect_to(root_path) }
    end
  end

end
