require "spec_helper"

describe UserMailer do

  let(:admin) { FactoryGirl.reload; FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:not_activated_user, company: company) }
  let(:company) { FactoryGirl.reload; FactoryGirl.create(:company) }

  describe "confirmation" do
    let(:mail) { UserMailer.confirmation(user) }

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("registration request has been received")
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    it 'sends to user' do
      user.reset_password
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      user.reset_password
      mail.body.encoded.should match("password reset request has been received")
    end
  end

  describe "invite" do
    let(:mail) { UserMailer.invite(user, admin) }

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      mail.body.encoded.should match("has invited you")
    end
  end

  describe "admin_invite" do
    let(:mail) { UserMailer.admin_invite(user) }

    it 'sends with subject' do
      expect(mail.subject).to eq('Marketplace Notification')
    end

    it 'sends to user' do
      expect(mail.to).to eq([user.email])
    end

    it 'sends from markeplace' do
      expect(mail.from).to eq(['marketplace@mail.com'])
    end

    it 'renders the body' do
      mail.body.encoded.should match("invited to become the Marketplace administrator")
    end
  end

end
