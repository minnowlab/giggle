require 'spec_helper'

describe ProductPicture do
  it "has a valid factory" do
    expect(create(:product_picture)).to be_valid 
  end
end
