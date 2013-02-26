require 'spec_helper'

describe AdminsController do

  let(:admin) { FactoryGirl.create(:admin)}

  describe 'GET show' do
    context 'authentacated user' do
      before {controller.stub!(:current_user).and_return(admin); get :show  }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end

    context 'not authentacated user' do
      before { get :show  }
      it { should redirect_to(root_path)  }
    end
  end

end
