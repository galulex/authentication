require "spec_helper"

describe CompanyMailer do

  let(:admin) { FactoryGirl.reload; FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:company) { FactoryGirl.reload; FactoryGirl.create(:company) }
  let(:date) { I18n.l(Time.now) }
  let(:reason) { 'reason' }

  describe "submitted" do
    let(:mail) { CompanyMailer.submitted(admin, user, company, date) }

    it 'sends with subject' do
      expect(mail.subject).to eq('AppZone Marketplace Notification')
    end

    it 'sends to admin' do
      expect(mail.to).to eq([admin.email])
    end

    it 'sends from markeplace' do
      expect(mail.from).to eq(['marketplace@partnerpedia.com'])
    end

    it 'renders the body' do
      mail.body.encoded.should match("submitted a request to publish a Company Profile")
    end
  end

  describe "declined" do
    let(:mail) { CompanyMailer.declined(user, company, reason) }

    it 'sends with to admin' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("An AppZone Marketplace Administrator has declined to publish")
    end
  end

  describe "published" do
    let(:mail) { CompanyMailer.approved(user, company) }

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("has been approved by an AppZone Marketplace administrator")
    end
  end

end
