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
        @word = params[:word]
        @brand = params[:brand]
        @color = params[:color]
        @shape = params[:shape]
        @carrying_style = params[:carrying_style]
        @style = params[:style]
        @closure_method = params[:closure_method]
        if @word.blank? && @brand.blank? && @color.blank? && @shape.blank? && @carrying_style.blank? && @style.blank? && @closure_method.blank?
            @products = Product.all.page(params[:page]).per(12)
        else
            @products = Product.all
            @products = @products.where(brand: @brand).page(params[:page]).per(12) if @brand.present?
            @products = @products.where(color: @color).page(params[:page]).per(12) if @color.present?
            @products = @products.where(shape: @shape).page(params[:page]).per(12) if @shape.present?
            @products = @products.where(carrying_style: @carrying_style).page(params[:page]).per(12) if @carrying_style.present?
            @products = @products.where(style: @style).page(params[:page]).per(12) if @style.present?
            @products = @products.where(closure_method: @closure_method).page(params[:page]).per(12) if @closure_method.present?
            @products = @products.looks(@word).page(params[:page]).per(12) if @word.present?
        end
    end
end

