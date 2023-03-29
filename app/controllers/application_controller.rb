class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  private 
    def sign_in_required
        redirect_to new_user_session_url unless user_signed_in?
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :username, 
        :username_kana, 
        :postal_code, 
        :prefecture_name, 
        :city, 
        :street_and_others, 
        :tel, 
        :birthday, 
        :sex, 
        :job
      ])
      devise_parameter_sanitizer.permit(:account_update, keys: [
        :username, 
        :username_kana, 
        :postal_code, 
        :prefecture_name,
        :city, 
        :street_and_others, 
        :tel, 
        :birthday,
        :sex, 
        :job
      ])
    end

end
