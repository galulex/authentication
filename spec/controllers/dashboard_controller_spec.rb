require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before { get :index }
    it { expect(response).to render_template(:index) }
    it { expect(assigns[:products]).to_not be_nil }
  end

end
