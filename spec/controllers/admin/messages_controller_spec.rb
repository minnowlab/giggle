require 'rails_helper'

describe Admin::MessagesController do
  before :each do
    set_user_session create(:user)
  end

  describe 'GET#index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe'GET#edit'do
    let(:message) { create(:message) }

    it "assigns the requested message" do
      get :edit, id: message
      expect(assigns(:message)).to eq message
    end

    it "renders the :edit template" do
      get :edit, id: message
      expect(response).to render_template :edit
    end 
  end

  describe 'PATCH#update' do 
    let(:message) { create(:message, content: "About the content.") }

    context "valid attributes" do
      it "located the requested message" do
        patch :update, id: message, message: attributes_for(:message)
        expect(assigns(:message)).to eq(message) 
      end

      it "changes message's attributes" do 
        patch :update, id: message, message: attributes_for(:message, content: "Edit the content.")
        message.reload
        expect(message.content).to eq("Edit the content.")
      end

      it "redirects to the updated message" do
        patch :update, id: message, message: attributes_for(:message) 
        expect(response).to redirect_to admin_messages_path
      end 
    end
    
    context "with invalid attributes" do
      it "does not change the message's attributes" do
        patch :update, id: message, message: attributes_for(:nil_content_message) 
        message.reload 
        expect(message.content).to eq("About the content.") 
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE#destroy' do 
    let(:message) { create(:message) }

    it "deletes the message" do 
      expect{
        delete :destroy, id: message
      }.to change(Message, :count).by(0)
    end

    it "redirects to messages#index" do
      delete :destroy, id: message 
      expect(response).to redirect_to admin_messages_path
    end 
  end
end
