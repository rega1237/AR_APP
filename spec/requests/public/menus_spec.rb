require 'rails_helper'

RSpec.describe "Public::Menus", type: :request do
  let!(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
  let!(:menu) { Menu.create!(client: client, name: 'Main Menu') }

  describe "GET /v/:client_slug" do
    context "when client exists" do
      it "renders a successful response" do
        get public_client_menu_path(client_slug: client.slug)
        expect(response).to be_successful
      end
    end

    context "when client does not exist" do
      it "returns a 404 not found" do
        get "/v/non-existent-client"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
