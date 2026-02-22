require 'rails_helper'

RSpec.describe "Admin::Menus", type: :request do
  let(:user) { User.create!(email_address: 'admin@example.com', password: 'password') }
  let(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com', contact_phone: '12345') }
  let(:valid_attributes) { { name: 'Dinner Menu', description: 'Our evening offerings' } }
  let(:invalid_attributes) { { name: '' } }

  before do
    post session_url, params: { email_address: user.email_address, password: 'password' }
  end

  describe "GET /admin/clients/:client_id/menus" do
    it "renders a successful response" do
      Menu.create! valid_attributes.merge(client: client)
      get admin_client_menus_path(client)
      expect(response).to be_successful
    end
  end

  describe "GET /admin/clients/:client_id/menus/new" do
    it "renders a successful response" do
      get new_admin_client_menu_path(client)
      expect(response).to be_successful
    end
  end

  describe "POST /admin/clients/:client_id/menus" do
    context "with valid parameters" do
      it "creates a new Menu and redirects to the menu show page" do
        expect {
          post admin_client_menus_path(client), params: { menu: valid_attributes }
        }.to change(Menu, :count).by(1)
        expect(response).to redirect_to(admin_menu_path(Menu.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Menu and renders unprocessable_content" do
        expect {
          post admin_client_menus_path(client), params: { menu: invalid_attributes }
        }.to change(Menu, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "GET /admin/menus/:id" do
    it "renders a successful response" do
      menu = Menu.create! valid_attributes.merge(client: client)
      get admin_menu_path(menu)
      expect(response).to be_successful
    end
  end

  describe "GET /admin/menus/:id/edit" do
    it "renders a successful response" do
      menu = Menu.create! valid_attributes.merge(client: client)
      get edit_admin_menu_path(menu)
      expect(response).to be_successful
    end
  end

  describe "PATCH /admin/menus/:id" do
    let(:menu) { Menu.create! valid_attributes.merge(client: client) }

    context "with valid parameters" do
      let(:new_attributes) { { name: 'Lunch Menu' } }

      it "updates the requested menu and redirects to the menu" do
        patch admin_menu_path(menu), params: { menu: new_attributes }
        menu.reload
        expect(menu.name).to eq('Lunch Menu')
        expect(response).to redirect_to(admin_menu_path(menu))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template with 422 status)" do
        patch admin_menu_path(menu), params: { menu: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /admin/menus/:id" do
    it "destroys the requested menu and redirects to the client's menu list" do
      menu = Menu.create! valid_attributes.merge(client: client)
      expect {
        delete admin_menu_path(menu)
      }.to change(Menu, :count).by(-1)
      expect(response).to redirect_to(admin_client_path(client))
    end
  end
end
