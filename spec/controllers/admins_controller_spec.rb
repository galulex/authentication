require 'spec_helper'

describe AdminsController do

  let(:admin) { FactoryGirl.create(:admin)}

  before { controller.stub!(:current_user).and_return(admin) }

  describe 'GET show' do
    before { get :show  }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

end
