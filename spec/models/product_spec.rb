require 'spec_helper'

describe Product do
  it "has a valid factory" do
    expect(create(:product)).to be_valid 
  end

  describe 'is invalid without a params' do
    it { expect(build(:nil_name_product)).to have(1).errors_on(:name) }
    it { expect(build(:nil_product_category_id_product)).to have(1).errors_on(:product_category_id) }
  end
end
