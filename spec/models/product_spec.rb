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

  describe ".search" do
    before :each do
      @product = create(:product)
    end

    it "have name" do
      expect(Product.search(name: @product.name).count).to eq(1)
    end

    it "have min price" do
      expect(Product.search(min_price: 100).count).to eq(1)
    end

    it "have max price" do
      expect(Product.search(max_price: 200).count).to eq(1)
    end

    it "have product category id" do
      expect(Product.search(product_category_id: @product.product_category_id).count).to eq(1)
    end
  end
end
