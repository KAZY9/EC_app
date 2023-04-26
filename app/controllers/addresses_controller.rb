class AddressesController < ApplicationController
    before_action :sign_in_required
    before_action :correct_user, only: [:destroy]

    def index
    end
    
    def new 
        @address = Address.new
    end

    def create 
        @address = current_user.addresses.build(address_params)
        if @address.save
            redirect_to addresses_url
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @address = current_user.addresses.find(params[:id])
        Rails.logger.debug(@address.inspect)
    end

    def update
        @address = Address.find(params[:id])
        if @address.update(address_params)
            redirect_to addresses_url
        else 
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @address.destroy
            redirect_to addresses_url,  status: :see_other
        end
    end

    protected

    def address_params
        params.require(:address).permit(:name, :name_kana, :company, :postal_code, 
                                        :prefecture_code, :city, :street_and_others, :tel)
    end

    def correct_user
        @address = current_user.addresses.find_by(id: params[:id])
        redirect_to addresses_url, status: :see_other if @address.nil?
    end
end
