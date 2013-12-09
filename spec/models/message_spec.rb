require 'spec_helper'

describe Message do
  it "has a valid factory" do
    expect(create(:message)).to be_valid 
  end

  describe 'is invalid without a params' do
    it { expect(build(:nil_content_message)).to have(1).errors_on(:content) }
  end
end
