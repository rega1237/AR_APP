require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  describe "GET /index" do
    context "when not authenticated" do
      it "redirects to the login page" do
        get admin_dashboard_index_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated" do
      let(:user) { User.create!(email_address: "admin@ar-menu.com", password: "password", password_confirmation: "password") }

      it "returns http success" do
        post session_path, params: { email_address: user.email_address, password: "password" }
        get admin_dashboard_index_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
