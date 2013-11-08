require 'spec_helper'

describe Product do
  it "has a valid factory" do
    expect(create(:product)).to be_valid 
  end

  it "is invalid without a name" do
    expect(build(:product, name: nil) ).to have(1).errors_on(:name)
  end
end
