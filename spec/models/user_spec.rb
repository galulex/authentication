require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }

  context 'validations' do

    it 'should be valid' do
      user.should be_valid
    end

    it 'should not create without email' do
      user.email = nil
      user.save
      user.should have(1).error_on(:email)
    end

    it 'should not create with invalid email' do
      user.email = 'email'
      user.save
      user.should have(1).error_on(:email)
    end

    it 'should not create without password' do
      user.password = nil
      user.password_confirmation = nil
      user.save
      user.should have(1).error_on(:password)
    end

    it 'should not create if password does not match confirmation' do
      user.password_confirmation = ""
      user.save
      user.should have(1).error_on(:password)
    end
  end

  context 'methods' do

    it 'should activate user' do
      user.save
      user.activated?.should be_false
      user.activate
      user.activated?.should be_true
    end

    it 'should return false if user is not activated' do
      user.activated?.should be_false
    end

    it 'should return true if user is activated' do
      user.save
      user.activate
      user.activated?.should be_true
    end

    it 'should generate token' do
      user.token = nil
      user.generate_token(:token)
      user.token.should_not be_blank
    end

    it 'should send reset password email' do
      user.save
      user.send_password_reset
      user.password_reset_token.should_not be_blank
      user.password_reset_sent_at.should_not be_blank
    end

  end

end
