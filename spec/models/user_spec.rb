require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(create(:user)).to be_valid 
  end

  describe 'is invalid without a params' do
    it "nil email user" do
      user = build(:nil_email_user)
      expect(user.valid?).to be_falsey
      expect(user.errors[:email].size).to eq(2)
    end

    it "nil password user" do
      user = build(:nil_password_user)
      expect(user.valid?).to be_falsey
      expect(user.errors[:password].size).to eq(2)
    end

    it "nil password_confirmation user" do
      user = build(:nil_password_confirmation_user)
      expect(user.valid?).to be_falsey
      expect(user.errors[:password_confirmation].size).to eq(1)
    end
  end
end
