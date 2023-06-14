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
    if @product
      if current_user
        @favorite = Favorite.find_by(user_id: current_user.id, product_id: @product.id)
      end
    else
      redirect_to root_path
    end
  end
end
