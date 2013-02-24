require 'spec_helper'

describe User do

  let(:company) { FactoryGirl.build(:company) }
  let(:user) { FactoryGirl.create(:not_activated_user, company: company) }
  let(:tenant) { FactoryGirl.build(:admin, company: company) }
  let(:partner) { FactoryGirl.build(:user, company: company) }

  describe 'associations' do
    it { should have_many(:logins) }
    it { should have_many(:notifications) }
    it { should have_many(:product_reviews) }
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_confirmation_of(:password) }
    it { should validate_uniqueness_of(:email) }
  end

  describe '#activate' do
    it 'activates user' do
      expect { user.activate }.to change(user, :token).to(nil)
    end
  end

  describe '#activated?' do
    it 'returns false if user is not activated' do
      expect(user.activated?).to be_false
    end

    it 'returns true if user is activated' do
      user.activate
      expect(user.activated?).to be_true
    end
  end

  describe '#reset_password' do
    it 'generates password_reset_token' do
      user.reset_password
      expect(user.password_reset_token).to_not be_nil
    end
  end

  describe '#name' do
    it 'returns user name' do
      expect(user.name).to eql("#{user.first_name} #{user.last_name}")
    end
  end

  describe '#role' do
    it 'retutns user role' do
      expect(user.role).to eql(User::ADMIN)
    end
  end

  describe '#admin?' do
    it 'returns false if user is not admin' do
      user.role_id = User::ROLES.invert[User::EMPLOYEE]
      expect(user.admin?).to be_false
    end

    it 'returns true if user is admin' do
      expect(user.admin?).to be_true
    end
  end

  describe '#tenant?' do
    it 'returns false if user is not tenant' do
      expect(user.tenant?).to be_false
    end

    it 'returns true if user is tenant' do
      expect(tenant.tenant?).to be_true
    end
  end

  describe '#partner?' do
    it 'returns false if user is not partner' do
      expect(tenant.partner?).to be_false
    end

    it 'returns true if user is partner' do
      expect(user.partner?).to be_true
    end
  end

  describe '#authenticate' do
    it 'returns false if user password is incorrect' do
      expect(user.authenticate('pass')).to be_false
    end

    it 'returns true if user password is correct' do
      expect(user.authenticate('P@ssword')).to be_true
    end
  end

  describe '#password=' do
    it 'sets password digest' do
      expect(user.password_digest).to_not be_nil
    end
  end

end

describe User::Tenant do

  describe '.model_name' do
    it 'returns user model name' do
      expect(User::Tenant.model_name).to eql('User')
    end
  end
end

describe User::Partner do

  describe '.model_name' do
    it 'returns user model name' do
      expect(User::Partner.model_name).to eql('User')
    end
  end
end
