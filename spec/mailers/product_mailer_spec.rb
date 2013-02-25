require "spec_helper"

describe ProductMailer do

  let(:admin) { FactoryGirl.reload; FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:company) { FactoryGirl.reload; FactoryGirl.create(:company) }
  let(:product) { FactoryGirl.create(:product, company: company) }
  let(:date) { I18n.l(Time.now) }
  let(:reason) { 'reason' }

  describe "submitted" do
    let(:mail) { ProductMailer.submitted(admin, user, company, product, date) }

    it 'sends to admin' do
      expect(mail.to).to eq([admin.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("submitted a request to publish the product")
    end
  end

  describe "retracted" do
    let(:mail) { ProductMailer.retracted(admin, user, company, product) }

    it 'sends to admin' do
      expect(mail.to).to eq([admin.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("has retracted the product")
    end
  end

  describe "declined" do
    let(:mail) { ProductMailer.declined(user, product, reason) }

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("An AppZone Marketplace Administrator has declined to publish")
    end
  end

  describe "published" do
    let(:mail) { ProductMailer.published(user, company, product) }

    it 'sends with subject' do
      expect(mail.subject).to eq('AppZone Marketplace Notification')
    end

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'sends from markeplace' do
      expect(mail.from).to eq(['marketplace@partnerpedia.com'])
    end

    it 'renders the body' do
      mail.body.encoded.should match("has been approved for publishing")
    end
  end

  describe "unpublished" do
    let(:mail) { ProductMailer.unpublished(user, product, reason) }

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("An AppZone Marketplace Administrator has unpublished your product")
    end
  end

end
