require 'rails_helper'

RSpec.describe "Public::Dishes", type: :request do
  let!(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
  let!(:menu) { Menu.create!(client: client, name: 'Main Menu') }
  let!(:category) { Category.create!(menu: menu, name: 'Starters') }
  let!(:dish) { Dish.create!(category: category, name: 'Salad', description: 'Fresh salad', price: 10.0) }

  describe "GET /v/:client_slug/d/:id" do
    context "when client and dish exist and dish belongs to client" do
      it "renders a successful response" do
        get public_client_dish_path(client_slug: client.slug, id: dish.id)
        expect(response).to be_successful
      end
    end

    context "when client does not exist" do
      it "returns a 404 not found" do
        get "/v/non-existent-client/d/#{dish.id}"
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when dish does not exist" do
      it "returns a 404 not found" do
        get "/v/#{client.slug}/d/99999"
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when dish belongs to a different client" do
      let!(:other_client) { Client.create!(name: 'Other Client', contact_email: 'other@example.com') }
      let!(:other_menu) { Menu.create!(client: other_client, name: 'Other Menu') }
      let!(:other_category) { Category.create!(menu: other_menu, name: 'Other Starters') }
      let!(:other_dish) { Dish.create!(category: other_category, name: 'Other Salad', description: 'Other salad', price: 10.0) }

      it "returns a 404 not found" do
        get "/v/#{client.slug}/d/#{other_dish.id}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
