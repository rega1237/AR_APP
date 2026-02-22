require 'rails_helper'

RSpec.describe "Admin::Dishes", type: :request do
  let(:user) { User.create!(email_address: 'admin@example.com', password: 'password') }
  let(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
  let(:menu) { Menu.create!(name: 'Main Menu', client: client) }
  let(:category) { Category.create!(name: 'Appetizers', menu: menu) }
  let(:valid_attributes) { { name: 'Spring Rolls', description: 'Crispy', price: 5.99, is_visible: true } }
  let(:invalid_attributes) { { name: '', price: -5 } }

  before do
    post session_url, params: { email_address: user.email_address, password: 'password' }
  end

  describe "GET /admin/categories/:category_id/dishes/new" do
    it "renders a successful response" do
      get new_admin_category_dish_path(category)
      expect(response).to be_successful
    end
  end

  describe "POST /admin/categories/:category_id/dishes" do
    context "with valid parameters" do
      it "creates a new Dish and redirects to the menu" do
        expect {
          post admin_category_dishes_path(category), params: { dish: valid_attributes }
        }.to change(Dish, :count).by(1)
        expect(response).to redirect_to(admin_menu_path(menu))
      end
    end

    context "with invalid parameters" do
      it "does not create and renders 422" do
        expect {
          post admin_category_dishes_path(category), params: { dish: invalid_attributes }
        }.to change(Dish, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "GET /admin/dishes/:id/edit" do
    it "renders a successful response" do
      dish = Dish.create! valid_attributes.merge(category: category)
      get edit_admin_dish_path(dish)
      expect(response).to be_successful
    end
  end

  describe "PATCH /admin/dishes/:id" do
    let(:dish) { Dish.create! valid_attributes.merge(category: category) }

    context "with valid parameters" do
      let(:new_attributes) { { price: 6.99 } }

      it "updates the Dish and redirects to the menu" do
        patch admin_dish_path(dish), params: { dish: new_attributes }
        dish.reload
        expect(dish.price).to eq(6.99)
        expect(response).to redirect_to(admin_menu_path(menu))
      end
    end

    context "with invalid parameters" do
      it "renders 422" do
        patch admin_dish_path(dish), params: { dish: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /admin/dishes/:id" do
    it "destroys the dish and redirects to the menu" do
      dish = Dish.create! valid_attributes.merge(category: category)
      expect {
        delete admin_dish_path(dish)
      }.to change(Dish, :count).by(-1)
      expect(response).to redirect_to(admin_menu_path(menu))
    end
  end
end
