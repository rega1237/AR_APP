class Admin::MenusController < Admin::BaseController
  before_action :set_client, only: %i[ index new create ]
  before_action :set_menu, only: %i[ show edit update destroy ]

  def index
    @menus = @client.menus
  end

  def show
  end

  def new
    @menu = @client.menus.build
  end

  def edit
  end

  def create
    @menu = @client.menus.build(menu_params)

    if @menu.save
      redirect_to admin_menu_path(@menu), notice: "Menu was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @menu.update(menu_params)
      redirect_to admin_menu_path(@menu), notice: "Menu was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @client = @menu.client
    @menu.destroy!
    redirect_to admin_client_path(@client), notice: "Menu was successfully destroyed."
  end

  private
    def set_client
      @client = Client.find(params[:client_id])
    end

    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
      params.expect(menu: [ :name, :description ])
    end
end
