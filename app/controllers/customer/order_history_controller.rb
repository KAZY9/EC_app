class Customer::OrderHistoryController < ApplicationController
    before_action :sign_in_required
    before_action :is_admin?

    def index
        @order_histories = Order.includes(:order_details, order_details: :product).where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
        @order = Order.includes(:order_details, order_details: :product, user: :orders).find_by(id: params[:id])

        if @order.payment_method == "クレジット決済"
            card = Card.find_by(id: @order.card_id)
            if card
                customer = Payjp::Customer.retrieve(card.customer_id)
                @card_info = customer.cards.retrieve(card.token_id)
            end
        end
    end

    private

    def is_admin?
        redirect_to root_url if current_user && current_user.admin?
    end
end
