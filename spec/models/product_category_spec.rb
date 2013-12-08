require 'spec_helper'

describe ProductCategory do
  it "has a valid factory" do
    expect(create(:product_category)).to be_valid 
  end

  describe 'is invalid without a params' do
    it { expect(build(:nil_name_product_category)).to have(1).errors_on(:name) }
  end
end
