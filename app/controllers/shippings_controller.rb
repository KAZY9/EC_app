class ShippingsController < ApplicationController
    before_action :authenticate_user!

    def shipping_address
        @address_id = Shipping.where(user_id: current_user.id).pluck(:address_id)
    end

    def new_address 
        @address = Address.new
    end

    def add_address
        @address = current_user.addresses.build(address_params)
        if @address.save
            redirect_to shippings_shipping_address_url
        else
            render :new, status: :unprocessable_entity
        end
    end

    def create
        @shipping_address = Shipping.find_by(user_id: current_user.id)
        if @shipping_address
            if @shipping_address.update(address_id: params[:address_id])
                redirect_to orders_url
            else
                render :index, status: :unprocessable_entity
            end
        else 
            @shipping = current_user.shippings.build(address_id: params[:address_id])
            if @shipping.save
                redirect_to orders_url
            else
                render :index, status: :unprocessable_entity
            end
        end
    end

    def new_credit
    end

    def add_credit
        customer = Payjp::Customer.create(
          description: 'test', 
          card: params[:token_id]
        )
        @card = Card.new(
          customer_id: customer.id,
          token_id: customer.default_card,
          user_id: current_user.id
        )
        if @card.save
          redirect_to orders_path
        end
    end

    private

    def address_params
        params.require(:address).permit(:name, :name_kana, :company, :postal_code, 
                                        :prefecture_code, :city, :street_and_others, :tel)
    end
end
