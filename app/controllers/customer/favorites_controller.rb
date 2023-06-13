class Customer::FavoritesController < ApplicationController
    before_action :set_product, except: [:index]
    before_action :set_favorite, only: [:destroy, :destroy_favorite_item]
    before_action :authenticate_user!

    def index
      product_ids = Favorite.where(user_id: current_user.id).pluck(:product_id)
      @favorite_list = Product.where(id: product_ids).page(params[:page]).per(12)
    end
  
    def create
      @favorite = Favorite.create(user_id: current_user.id, product_id: @product.id)
      render turbo_stream: turbo_stream.replace(
        'add-favorite-button',
        partial: 'customer/favorites/favorites',
        locals: { product: @product, liked: true },
      )
    end
    
    def destroy
      @favorite.destroy
      render turbo_stream: turbo_stream.replace(
        'add-favorite-button',
        partial: 'customer/favorites/favorites',
        locals: { product: @product, liked: false },
      )
    end

    def destroy_favorite_item
      if @favorite.destroy
        redirect_to favorites_path, status: :see_other
      end
    end
  
    private

    def set_product
      if params[:product_id].present?
        @product = Product.find(params[:product_id])
      else
        redirect_to root_path
      end
    end

    def set_favorite
      @favorite = Favorite.find_by(user_id: current_user.id, product_id: @product.id)
      if @favorite.nil?
        redirect_to root_path
      end
    end

    def authenticate_user!
      unless current_user
        redirect_to mypage_login_path # ログインページにリダイレクト
      end
    end
end
