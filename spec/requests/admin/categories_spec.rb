require 'rails_helper'

RSpec.describe "Admin::Categories", type: :request do
  let(:user) { User.create!(email_address: 'admin@example.com', password: 'password') }
  let(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
  let(:menu) { Menu.create!(name: 'Main Menu', client: client) }
  let(:valid_attributes) { { name: 'Appetizers', description: 'Starters', position: 1 } }
  let(:invalid_attributes) { { name: '' } }

  before do
    post session_url, params: { email_address: user.email_address, password: 'password' }
  end

  describe "GET /admin/menus/:menu_id/categories/new" do
    it "renders a successful response" do
      get new_admin_menu_category_path(menu)
      expect(response).to be_successful
    end
  end

  describe "POST /admin/menus/:menu_id/categories" do
    context "with valid parameters" do
      it "creates a new Category and redirects to the menu" do
        expect {
          post admin_menu_categories_path(menu), params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
        expect(response).to redirect_to(admin_menu_path(menu))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Category and renders 422" do
        expect {
          post admin_menu_categories_path(menu), params: { category: invalid_attributes }
        }.to change(Category, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "GET /admin/categories/:id/edit" do
    it "renders a successful response" do
      category = Category.create! valid_attributes.merge(menu: menu)
      get edit_admin_category_path(category)
      expect(response).to be_successful
    end
  end

  describe "PATCH /admin/categories/:id" do
    let(:category) { Category.create! valid_attributes.merge(menu: menu) }

    context "with valid parameters" do
      let(:new_attributes) { { name: 'Starters' } }

      it "updates the Category and redirects to the menu" do
        patch admin_category_path(category), params: { category: new_attributes }
        category.reload
        expect(category.name).to eq('Starters')
        expect(response).to redirect_to(admin_menu_path(menu))
      end
    end

    context "with invalid parameters" do
      it "renders unprocessable_content" do
        patch admin_category_path(category), params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /admin/categories/:id" do
    it "destroys the category and redirects to the menu" do
      category = Category.create! valid_attributes.merge(menu: menu)
      expect {
        delete admin_category_path(category)
      }.to change(Category, :count).by(-1)
      expect(response).to redirect_to(admin_menu_path(menu))
    end
  end
end
