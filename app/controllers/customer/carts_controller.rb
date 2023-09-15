class Customer::CartsController < ApplicationController
  before_action :sign_in_required
  before_action :set_cart_item, only: [:increase, :decrease, :destroy]

  def index
    @cart_list = Cart.joins(:product).where(user_id: current_user.id).select("carts.*, products.price")
    @total_price = @cart_list.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    increase_or_create(params[:cart][:product_id], params[:cart][:quantity].to_i)
  end

  def increase
    @cart_item.increment!(:quantity, 1)
    redirect_to request.referer
  end

  def decrease
    decrease_or_destory(@cart_item)
    redirect_to request.referer
  end

  def destroy
    @cart_item.destroy
    redirect_to request.referer
  end

  private

  def set_cart_item
    @cart_item = current_user.carts.find(params[:id])
  end

  def increase_or_create(product_id, quantity)
    cart_item = current_user.carts.find_by(product_id: product_id)
    if cart_item
      cart_item.increment!(:quantity, quantity)
    else
      current_user.carts.create(product_id: product_id, quantity: quantity).save
    end
  end 

  def decrease_or_destory(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:quantity, 1)
    else
      cart_item.destroy
    end
  end
end
