class Customer::ProductsController < ApplicationController
  def index
    @products_latest = Product.latest.limit(10)
    latest_product_ids = @products_latest.pluck(:id)

    # @products_recommend = Product.limit(10)

    @products = Product.where.not(id: latest_product_ids).limit(12)
   
    if @products_latest.nil? || @products.nil?
      redirect_to products_url
    end
  end

  def show
    @product = Product.find(params[:id])
    if current_user
      @favorite = Favorite.find_by(user_id: current_user.id, product_id: @product.id)
    end
    redirect_to products_url unless @product 
  end
end
