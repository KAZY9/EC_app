class Admin::ProductsController < ApplicationController
  before_action :is_not_admin?
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product)
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
        redirect_to admin_products_url,  status: :see_other
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :color, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def is_not_admin?
    redirect_to root_url unless current_user && current_user.admin?
  end
end
