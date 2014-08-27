require 'rails_helper'

describe Product do
  it "has a valid factory" do
    expect(create(:product)).to be_valid 
  end

  describe 'is invalid without a params' do
    it "nil name product" do
      product = build(:nil_name_product)
      expect(product.valid?).to be_falsey
      expect(product.errors[:name].size).to eq(1)
    end

    it "nil product category id product" do
      product = build(:nil_product_category_id_product)
      expect(product.valid?).to be_falsey
      expect(product.errors[:product_category_id].size).to eq(1)
    end
  end
end
