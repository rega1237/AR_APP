class Admin::DishesController < Admin::BaseController
  before_action :set_category, only: %i[ new create ]
  before_action :set_dish, only: %i[ edit update destroy ]

  def new
    @dish = @category.dishes.build
  end

  def edit
  end

  def create
    @dish = @category.dishes.build(dish_params)

    if @dish.save
      redirect_to admin_menu_path(@category.menu), notice: "Dish was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @dish.update(dish_params)
      redirect_to admin_menu_path(@dish.category.menu), notice: "Dish was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @menu = @dish.category.menu
    @dish.destroy!
    redirect_to admin_menu_path(@menu), notice: "Dish was successfully destroyed."
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_dish
      @dish = Dish.find(params[:id])
    end

    def dish_params
      params.expect(dish: [ :name, :description, :price, :position, :is_visible, :photo, :model_3d ])
    end
end
