class Admin::CategoriesController < Admin::BaseController
  before_action :set_menu, only: %i[ new create ]
  before_action :set_category, only: %i[ edit update destroy ]

  def new
    @category = @menu.categories.build
  end

  def edit
  end

  def create
    @category = @menu.categories.build(category_params)

    if @category.save
      redirect_to admin_menu_path(@menu), notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_menu_path(@category.menu), notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @menu = @category.menu
    @category.destroy!
    redirect_to admin_menu_path(@menu), notice: "Category was successfully destroyed."
  end

  private
    def set_menu
      @menu = Menu.find(params[:menu_id])
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.expect(category: [ :name, :description, :position ])
    end
end
