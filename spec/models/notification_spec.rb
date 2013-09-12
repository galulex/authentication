require 'spec_helper'

describe Notification do

  let(:company) { FactoryGirl.build(:company) }
  let(:user) { FactoryGirl.build(:user, company: company) }
  let(:product) { FactoryGirl.create(:product, company: company) }
  let(:notification) { FactoryGirl.create(:notification, user: user, data: { company: company.name, product: product.name }) }

  describe '#message' do
    it 'returns notification message' do
      expect(notification.message).to include(product.name)
    end
  end

end
