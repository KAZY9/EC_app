class Customer::ProductsController < ApplicationController
  def index
    @products_latest = Product.latest.limit(10)
    # @products_recommend = Product.limit(10)
    latest_product_ids = @products_latest.pluck(:id)
    @products = Product.where.not(id: latest_product_ids).limit(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
