module Public
  class DishesController < ApplicationController
    allow_unauthenticated_access

    def show
      @client = Client.find_by!(slug: params[:client_slug])
      # Ensure the dish actually belongs to the specified client to prevent ID guessing
      @dish = Dish.joins(category: :menu).where(menus: { client_id: @client.id }).find(params[:id])
    end
  end
end
