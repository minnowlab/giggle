require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(create(:user)).to be_valid 
  end

  describe 'is invalid without a params' do
    it { expect(build(:nil_email_user)).to have(2).errors_on(:email) }
    it { expect(build(:nil_password_user)).to have(2).errors_on(:password) }
    it { expect(build(:nil_password_confirmation_user)).to have(1).errors_on(:password_confirmation) }
  end
end
