require 'spec_helper'

describe Reports::Dashboard do

  let(:company) { FactoryGirl.build(:company) }
  let!(:user) { FactoryGirl.create(:not_activated_user, company: company) }
  let(:login) { user.logins.create }

  describe '#initialize' do
    it 'sets report attributes' do
      report = Reports::Dashboard.new(start: 1.day.ago, end: Time.now)
      expect(report.logins_count).to_not be_blank
    end
  end

end
