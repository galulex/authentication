require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should render_with_layout(:dashboard) }
    it { should assign_to(:products) }
  end

end
