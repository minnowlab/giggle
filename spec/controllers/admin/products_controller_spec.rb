require 'spec_helper'

describe Admin::ProductsController do
  describe 'GET#index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe'GET#new'do
    it "assigns a new Product to @product" do
      get :new
      expect(assigns(:product)).to be_a_new(Product) 
    end

    it "renders the :new template" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe'GET#edit'do
    it "assigns the requested product to @product" do
      product = create(:product)
      get :edit, id: product
      expect(assigns(:product)).to eq product
    end

    it "renders the :edit template" do
      product = create(:product)
      get :edit, id: product
      expect(response).to render_template :edit
    end 
  end

  describe"POST#create"do
    before :each do
      @product = [
        attributes_for(:product),
        attributes_for(:product),
        attributes_for(:product)
      ]
    end

    context "with valid attributes" do
      it "saves the new product in the database" do
        expect{
          post :create, product: attributes_for(:product, products_attributes: @product)
        }.to change(Product, :count).by(1)
      end

      it "redirects to products#index" do
        post :create, product: attributes_for(:product, products_attributes: @product)
        expect(response).to redirect_to admin_products_path
      end 
    end

    context "with invalid attributes" do
      it "does not save the new product in the database" do
        expect{
          post :create, product: attributes_for(:invalid_product)
        }.to_not change(Product, :count)
      end

      it "re-renders the :new template" do 
        post :create, product: attributes_for(:invalid_product)
        expect(response).to render_template :new
      end 
    end
  end

  describe 'PATCH#update' do 
    before :each do
      @product = create(:product, name: 'Lily', description: 'About the Lily.')
    end

    context "valid attributes" do
      it "located the requested @product" do
        patch :update, id: @product, product: attributes_for(:product)
        expect(assigns(:product)).to eq(@product) 
      end

      it "changes @product's attributes" do 
        patch :update, id: @product, product: attributes_for(:product, name: "Larry", description: "About the Larry.", details: "Larry's details.", price: 200.5)
        @product.reload
        expect(@product.name).to eq("Larry")
        expect(@product.description).to eq("About the Larry.")
        expect(@product.details).to eq("Larry's details.")
        expect(@product.price).to eq(200.5)
      end

      it "redirects to the updated product" do
        patch :update, id: @product, product: attributes_for(:product) 
        expect(response).to redirect_to admin_products_path
      end 
    end
    
    context "with invalid attributes" do
      it "does not change the product's attributes" do
        patch :update, id: @product, product: attributes_for(:product, name: nil, description: "About the Larry.") 
        @product.reload 
        expect(@product.name).to eq("Lily") 
        expect(@product.description).to_not eq("About the Larry.")
      end

      it "re-renders the edit template" do
        patch :update, id: @product, product: attributes_for(:invalid_product) 
        expect(response).to render_template :edit
      end
    end
  end
end
