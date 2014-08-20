require 'rails_helper'

describe Admin::EvaluatesController do
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
    it "assigns a new Evaluate to evaluate" do
      get :new
      expect(assigns(:evaluate)).to be_a_new(Evaluate) 
    end

    it "renders the :new template" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe"POST#create"do
    context "with valid attributes" do
      it "saves the new evaluate in the database" do
        expect{
          post :create, evaluate: attributes_for(:evaluate, user_id: 1, product_id: 1)
        }.to change(Evaluate, :count).by(1)
      end

      it "redirects to evaluates#index" do
        post :create, evaluate: attributes_for(:evaluate, user_id: 1, product_id: 1)
        expect(response).to redirect_to admin_evaluates_path
      end 
    end

    context "with invalid attributes" do
      it "does not save the new evaluate in the database" do
        expect{
          post :create, evaluate: attributes_for(:nil_title_evaluate)
        }.to_not change(Evaluate, :count)
      end

      it "re-renders the :new template" do 
        post :create, evaluate: attributes_for(:nil_title_evaluate)
        expect(response).to render_template :new
      end 
    end
  end

  describe'GET#edit'do
    let(:evaluate) { create(:evaluate) }

    it "assigns the requested evaluate" do
      get :edit, id: evaluate
      expect(assigns(:evaluate)).to eq evaluate
    end

    it "renders the :edit template" do
      get :edit, id: evaluate
      expect(response).to render_template :edit
    end 
  end

  describe 'PATCH#update' do 
    let(:evaluate) { create(:evaluate, title: 'Toy Evaluate', details: 'About the Toy.') }

    context "valid attributes" do
      it "located the requested evaluate" do
        patch :update, id: evaluate, evaluate: attributes_for(:evaluate)
        expect(assigns(:evaluate)).to eq(evaluate) 
      end

      it "changes evaluate's attributes" do 
        patch :update, id: evaluate, evaluate: attributes_for(:evaluate, title: "Art Evaluate", details: "About the Art.")
        evaluate.reload
        expect(evaluate.title).to eq("Art Evaluate")
        expect(evaluate.details).to eq("About the Art.")
      end

      it "redirects to the updated evaluate" do
        patch :update, id: evaluate, evaluate: attributes_for(:evaluate) 
        expect(response).to redirect_to admin_evaluates_path
      end 
    end
    
    context "with invalid attributes" do
      it "does not change the evaluate's attributes" do
        patch :update, id: evaluate, evaluate: attributes_for(:evaluate, title: nil, details: "About the Art.") 
        evaluate.reload 
        expect(evaluate.title).to eq("Toy Evaluate") 
        expect(evaluate.details).to_not eq("About the Art.")
      end

      it "re-renders the edit template" do
        patch :update, id: evaluate, evaluate: attributes_for(:nil_title_evaluate) 
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE#destroy' do 
    let(:evaluate) { create(:evaluate) }

    it "deletes the evaluate" do 
      expect{
        delete :destroy, id: evaluate
      }.to change(Evaluate, :count).by(0)
    end

    it "redirects to evaluates#index" do
      delete :destroy, id: evaluate 
      expect(response).to redirect_to admin_evaluates_path
    end 
  end
end
