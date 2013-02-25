require 'spec_helper'

describe Reports::Registration do

  let(:company) { FactoryGirl.build(:company) }
  let!(:user) { FactoryGirl.create(:not_activated_user, company: company) }
  let(:login) { user.logins.create }

  describe '#initialize' do
    it 'sets report attributes' do
      report = Reports::Registration.new(start: 1.day.ago, end: Time.now)
      expect(report.users).to_not be_blank
    end
  end

  describe '#csv' do
    it 'returns a string' do
      report = Reports::Registration.new(start: 1.day.ago, end: Time.now)
      expect(report.csv).to be_an_kind_of(String)
    end
  end

end
