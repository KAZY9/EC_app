class SearchesController < ApplicationController
    def search
        @word = params[:word]
        if @word.blank?
            @products = Product.all.page(params[:page]).per(12)
        else
            @products = Product.looks(@word).page(params[:page]).per(12)
        end
    end

    def filter_search
        if params[:word].blank? && params[:brand].blank? && params[:color].blank? && params[:shape].blank? && params[:carrying_style].blank? && params[:style].blank? && params[:closure_method].blank?
            @products = Product.all.page(params[:page]).per(12)
        else
            @products = Product.all
            @products = @products.where(brand: params[:brand]).page(params[:page]).per(12) if params[:brand].present?
            @products = @products.where(color: params[:color]).page(params[:page]).per(12) if params[:color].present?
            @products = @products.where(shape: params[:shape]).page(params[:page]).per(12) if params[:shape].present?
            @products = @products.where(carrying_style: params[:carrying_style]).page(params[:page]).per(12) if params[:carrying_style].present?
            @products = @products.where(style: params[:style]).page(params[:page]).per(12) if params[:style].present?
            @products = @products.where(closure_method: params[:closure_method]).page(params[:page]).per(12) if params[:closure_method].present?
            @products = @products.looks(params[:word]).page(params[:page]).per(12) if params[:word].present?
        end
    end

    def order_search
        order_number = params[:order_number]
        @order = Order.includes(:order_details, order_details: :product).where(order_number: order_number).page(params[:page]).per(12)
    end
end

