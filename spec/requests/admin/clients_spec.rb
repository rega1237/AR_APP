require 'rails_helper'

RSpec.describe "Admin::Clients", type: :request do
  let(:admin_user) { User.create!(email_address: "admin@ar-menu.com", password: "password", password_confirmation: "password") }
  let(:valid_attributes) {
    { name: "The Burger Joint", contact_email: "burger@example.com", address: "123 Burger St" }
  }
  let(:invalid_attributes) {
    { name: "", contact_email: "not-an-email" }
  }

  before do
    post session_path, params: { email_address: admin_user.email_address, password: "password" }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Client.create! valid_attributes
      get admin_clients_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      client = Client.create! valid_attributes
      get admin_client_path(client)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_client_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      client = Client.create! valid_attributes
      get edit_admin_client_path(client)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Client" do
        expect {
          post admin_clients_path, params: { client: valid_attributes }
        }.to change(Client, :count).by(1)
      end

      it "redirects to the created client" do
        post admin_clients_path, params: { client: valid_attributes }
        expect(response).to redirect_to(admin_client_path(Client.last))
      end

      it "attaches the uploaded logo" do
        file = fixture_file_upload(Rails.root.join('spec/fixtures/files/logo.png'), 'image/png')
        post admin_clients_path, params: { client: valid_attributes.merge(logo: file) }
        expect(Client.last.logo).to be_attached
      end
    end

    context "with invalid parameters" do
      it "does not create a new Client" do
        expect {
          post admin_clients_path, params: { client: invalid_attributes }
        }.to change(Client, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_clients_path, params: { client: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "The Improved Burger Joint" }
      }

      it "updates the requested client" do
        client = Client.create! valid_attributes
        patch admin_client_path(client), params: { client: new_attributes }
        client.reload
        expect(client.name).to eq("The Improved Burger Joint")
      end

      it "redirects to the client" do
        client = Client.create! valid_attributes
        patch admin_client_path(client), params: { client: new_attributes }
        client.reload
        expect(response).to redirect_to(admin_client_path(client))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        client = Client.create! valid_attributes
        patch admin_client_path(client), params: { client: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect {
        delete admin_client_path(client)
      }.to change(Client, :count).by(-1)
    end

    it "redirects to the clients list" do
      client = Client.create! valid_attributes
      delete admin_client_path(client)
      expect(response).to redirect_to(admin_clients_path)
    end
  end
end
