require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.build(:not_activated_user) }
  let(:tenant) { FactoryGirl.build(:admin) }
  let(:partner) { FactoryGirl.build(:user) }

  describe '#activate' do
    it 'activates user' do
      user.save
      expect { user.activate }.to change(user, :token).to(nil)
    end
  end

  describe '#activated?' do
    it 'returns false if user is not activated' do
      user.token = 'token'
      expect(user).to_not be_activated
    end

    it 'returns true if user is activated' do
      user.token = nil
      expect(user).to be_activated
    end
  end

  describe '#reset_password' do
    it 'generates password_reset_token' do
      expect { user.reset_password }.to change(user, :password_reset_token)
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
      user.role_id = User::ROLES.index(User::EMPLOYEE)
      expect(user).to_not be_admin
    end

    it 'returns true if user is admin' do
      expect(user).to be_admin
    end
  end

  describe '#tenant?' do
    it 'returns false if user is not tenant' do
      expect(user).to_not be_tenant
    end

    it 'returns true if user is tenant' do
      expect(tenant).to be_tenant
    end
  end

  describe '#partner?' do
    it 'returns false if user is not partner' do
      expect(tenant).to_not be_partner
    end

    it 'returns true if user is partner' do
      expect(user).to be_partner
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
