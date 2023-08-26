class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :init_payjp, only: [:new, :confirm, :create]


    def new
        @user = current_user
        
        set_cart_items

        @addreess_id = Shipping.where(user_id: current_user.id).pluck(:address_id)
        @shipping_address = Address.find_by(id: @addreess_id)

        cards = Card.where(user_id: current_user.id)
        @cards_list = []
        cards.each do |card|
            customer = Payjp::Customer.retrieve(card.customer_id)
            @cards_list.append({
                'customer' => customer.cards.data,
                'id' => card.id 
                })
        end

        if session[:order]
            @order = Order.new(session[:order])
            session.delete(:order)
        else
            @order = Order.new
        end
    end

    def confirm
        @user = User.find(current_user.id)

        set_cart_items

        if params[:order][:payment_method].to_i == Order.payment_methods["クレジット決済"]
            card = Card.find_by(id: params[:order][:card_id])
            if card
                customer = Payjp::Customer.retrieve(card.customer_id)
                @card_info = customer.cards.retrieve(card.token_id)
            end
        elsif params[:order][:payment_method].to_i == Order.payment_methods["代金引換"]
            params[:order][:card_id] = ""
        end

        @order = Order.new(order_params)
        render :new if @order.invalid?
    end

    def create
        @order = Order.new(order_params)
        generate_order_number
        @user = current_user
        
        if params[:back] 
            if params[:order][:payment_method].to_i == Order.payment_methods["代金引換"]
                params[:order][:card_id] = ""
            end
            set_cart_items
            set_card_list
            render :new
        else
            @cart_items = current_user.carts.includes(:product)
            all_products_have_stock = true

            # 商品の在庫をチェックする
            @cart_items.each do |cart|
                product = cart.product
                if product.stock < cart.quantity
                    all_products_have_stock = false
                    break  # 在庫が足りない商品が見つかったらループを中断
                end
            end

            if all_products_have_stock &&  @order.save
                if params[:order][:card_id]
                    if checkout(@order.billing_amount)
                        @order.status = :confirmed_payment
                        @order.save
                    end
                end

                @cart_items.each do |cart|
                    @order_item = OrderDetail.new
                    @order_item.product_id = cart.product_id
                    @order_item.order_id = @order.id
                    @order_item.quantity = cart.quantity
                    @order_item.price = cart.product.price
                    cart.product.stock -= @order_item.quantity
                    @order_item.save
                    cart.product.save
                end

                @cart_items.destroy_all
                OrderMailer.order_confirmation(current_user, @order).deliver_later
                redirect_to orders_complete_path(order_id: @order.id)
            else
                flash.now[:alert] = "在庫がありません。"
                render :new, status: :unprocessable_entity
            end
        end
    end

    def complete
        @order = Order.find_by(id: params[:order_id])
    end

    private

    def order_params
        pp = params.require(:order).permit(
                :user_id, 
                :name, 
                :name_kana, 
                :company, 
                :postal_code, 
                :prefecture_code, 
                :city, 
                :street_and_others, 
                :tel, 
                :delivery_date, 
                :delivery_time, 
                :commission, 
                :postage, 
                :billing_amount, 
                :status, 
                :payment_method, 
                :card_id, 
                :order_number
            )
        pp[:status] = params[:order][:status].to_i
        pp[:payment_method] = params[:order][:payment_method].to_i
        return pp
    end

    def init_payjp
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    end

    def set_card_list
        cards = Card.where(user_id: current_user.id)
        @cards_list = []
        cards.each do |card|
            customer = Payjp::Customer.retrieve(card.customer_id)
            @cards_list.append({
                'customer' => customer.cards.data,
                'id' => card.id 
                })
        end
    end

    def set_cart_items
        @cart_list = Cart.joins(:product).where(user_id: current_user.id).select("carts.*, products.price")
        @total_price = @cart_list.inject(0) { |sum, item| sum + item.sum_of_price }.round
    end

    def generate_order_number
        # 現在の最大の注文番号を取得
        max_order_number = Order.maximum(:order_number)
    
        # 注文番号をインクリメントして5桁のフォーマットに変換
        new_order_number = format('%05d', max_order_number.to_i + 1)
    
        # 注文番号をセット
        @order.order_number = new_order_number
    end

    def checkout(total_amount)
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPに秘密鍵をセット
        card = Card.find_by(id: params[:order][:card_id])
        if card
            charge = Payjp::Charge.create( # PAY.JPに購入価格と顧客id、通過の種類を渡す
            amount: total_amount,
            customer: card.customer_id,
            card: params[:token_id],
            currency: 'jpy' 
            )
        end
    end
end
