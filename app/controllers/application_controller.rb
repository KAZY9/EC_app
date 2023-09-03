class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_categories

  private 
    def sign_in_required
        redirect_to mypage_login_url unless user_signed_in?
    end

    def set_categories
      @categories = Category.all
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :username, 
        :username_kana, 
        :postal_code, 
        :prefecture_code, 
        :city, 
        :street_and_others, 
        :tel, 
        :birthday, 
        :sex, 
        :job,
        :agreement
      ])
      devise_parameter_sanitizer.permit(:account_update, keys: [
        :username, 
        :username_kana, 
        :postal_code, 
        :prefecture_code,
        :city, 
        :street_and_others, 
        :tel, 
        :birthday,
        :sex, 
        :job,
        :email
      ])
    end

end
