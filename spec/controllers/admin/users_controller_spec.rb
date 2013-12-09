require 'spec_helper'

describe Admin::UsersController do
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
    it "assigns a new User to user" do
      get :new
      expect(assigns(:user)).to be_a_new(User) 
    end

    it "renders the :new template" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe'GET#edit'do
    let(:user) { create(:user) }

    it "assigns the requested User to user" do
      get :edit, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :edit template" do
      get :edit, id: user
      expect(response).to render_template :edit
    end 
  end

  describe"POST#create"do
    let(:user) { build(:user) }

    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{
          post :create, user: attributes_for(:user, users_attributes: user)
        }.to change(User, :count).by(1)
      end

      it "redirects to users#index" do
        post :create, user: attributes_for(:user, users_attributes: user)
        expect(response).to redirect_to admin_users_path
      end 
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, user: attributes_for(:nil_email_user)
        }.to_not change(User, :count)
      end

      it "re-renders the :new template" do 
        post :create, user: attributes_for(:nil_email_user)
        expect(response).to render_template :new
      end 
    end
  end

  describe 'DELETE#destroy' do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    let(:user) { create(:user) }

    it "deletes the user" do 
      expect{
        delete :destroy, id: user
      }.to change(User, :count).by(0)
    end

    it "redirects to users#index" do
      delete :destroy, id: user 
      expect(response).to redirect_to "where_i_came_from"
    end 
  end
end
