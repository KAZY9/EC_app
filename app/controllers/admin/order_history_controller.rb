class Admin::OrderHistoryController < ApplicationController
    before_action :authenticate_user!
    before_action :is_not_admin?
    before_action :set_order, only: [:show, :edit, :update]
    before_action :set_card_info, only: [:show, :edit]

    def index
        @order_histories = Order.includes(:order_details, order_details: :product).order(created_at: :desc).page(params[:page]).per(5)
    end
    
    def show
    end

    def edit
    end

    def update
        if @order.update(order_params)
            redirect_to admin_order_history_path(@order)
        else
            render :edit
        end
    end

    private
    
    def order_params
        pp = params.require(:order).permit(:status)
        pp[:status] = params[:order][:status].to_i
        return pp
    end

    def set_card_info
        if @order.payment_method == "クレジット決済"
            card = Card.find_by(id: @order.card_id)
            if card
                customer = Payjp::Customer.retrieve(card.customer_id)
                @card_info = customer.cards.retrieve(card.token_id)
            end
        end
    end

    def set_order
        @order = Order.includes(:order_details, order_details: :product, user: :orders).find_by(id: params[:id])
        redirect_to admin_order_histroy_url unless @order
    end

    def is_not_admin?
        redirect_to root_url unless current_user && current_user.admin?
    end
end
