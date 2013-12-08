require 'spec_helper'

describe Admin::ProductCategoriesController do
  before :each do
    set_user_session create(:user)
  end

  describe 'GET#index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe'GET#new'do
    it "assigns a new ProductCategory to product_category" do
      get :new
      expect(assigns(:product_category)).to be_a_new(ProductCategory) 
    end

    it "renders the :new template" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe"POST#create"do
    let(:product_category) { build(:product_category) }

    context "with valid attributes" do
      it "saves the new product_category in the database" do
        expect{
          post :create, product_category: attributes_for(:product_category, products_attributes: product_category)
        }.to change(ProductCategory, :count).by(1)
      end

      it "redirects to product_categories#index" do
        post :create, product_category: attributes_for(:product_category, products_attributes: product_category)
        expect(response).to redirect_to admin_product_categories_path
      end 
    end

    context "with invalid attributes" do
      it "does not save the new product_category in the database" do
        expect{
          post :create, product_category: attributes_for(:nil_name_product_category)
        }.to_not change(ProductCategory, :count)
      end

      it "re-renders the :new template" do 
        post :create, product_category: attributes_for(:nil_name_product_category)
        expect(response).to render_template :new
      end 
    end
  end

  describe'GET#edit'do
    it "assigns the requested product_category to product_category" do
      product_category = create(:product_category)
      get :edit, id: product_category
      expect(assigns(:product_category)).to eq product_category
    end

    it "renders the :edit template" do
      product_category = create(:product_category)
      get :edit, id: product_category
      expect(response).to render_template :edit
    end 
  end

  describe 'PATCH#update' do 
    let(:product_category) { create(:product_category, name: 'Toy') }

    context "valid attributes" do
      it "located the requested @product_category" do
        patch :update, id: product_category, product_category: attributes_for(:product_category)
        expect(assigns(:product_category)).to eq(product_category) 
      end

      it "changes product_category's attributes" do 
        patch :update, id: product_category, product_category: attributes_for(:product_category, name: "Art")
        product_category.reload
        expect(product_category.name).to eq("Art")
      end

      it "redirects to the updated product_category" do
        patch :update, id: product_category, product_category: attributes_for(:product_category) 
        expect(response).to redirect_to admin_product_categories_path
      end 
    end
    
    context "with invalid attributes" do
      it "does not change the product_category's attributes" do
        patch :update, id: product_category, product_category: attributes_for(:product_category, name: nil) 
        product_category.reload 
        expect(product_category.name).to eq("Toy") 
      end

      it "re-renders the edit template" do
        patch :update, id: product_category, product_category: attributes_for(:nil_name_product) 
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE#destroy' do 
    let(:product_category) { create(:product_category) }

    it "deletes the product_category" do 
      expect{
        delete :destroy, id: product_category
      }.to change(ProductCategory, :count).by(0)
    end

    it "redirects to product_categories#index" do
      delete :destroy, id: product_category 
      expect(response).to redirect_to admin_product_categories_path
    end 
  end
end
