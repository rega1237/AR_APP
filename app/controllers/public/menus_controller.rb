module Public
  class MenusController < ApplicationController
    allow_unauthenticated_access

    def show
      @client = Client.find_by!(slug: params[:client_slug])
      # The client's menus, categories and dishes will be accessed in the view
    end
  end
end
