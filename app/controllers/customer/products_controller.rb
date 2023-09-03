class Customer::ProductsController < ApplicationController
  def index
    @products_latest = Product.latest.limit(10)
    latest_product_ids = @products_latest.pluck(:id)

    # @products_recommend = Product.limit(10)

    @products = Product.where.not(id: latest_product_ids).limit(12)
   
    if @products_latest.nil? || @products.nil?
      redirect_to root_path
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    @cart = Cart.new
    if @product
      if current_user
        @favorite = Favorite.find_by(user_id: current_user.id, product_id: @product.id)
      end
    else
      redirect_to root_path
    end
  end

  def product_list   
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      if params[:category_id].to_i == 1
        @products = Product.all.page(params[:page]).per(12)
      else
        @products = Product.where(category_id: params[:category_id]).page(params[:page]).per(12)
      end
    end
  end
end
