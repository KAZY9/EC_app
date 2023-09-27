class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_permitted_parameters, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    if session[:user]
      @user = User.new(session[:user])
      session.delete(:user)
    else
      @user = User.new
    end
  end

  def confirm
    @user = User.new(sign_up_params)
    if @user.invalid?
      render :new
    else
      session[:user] = sign_up_params
    end
  end

  def create
    @user = User.new(sign_up_params)
    if params[:back] 
      redirect_to sign_up_url
    elsif @user.save
      session.delete(:user)
      redirect_to sign_up_complete_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def complete
  end

protected

  # アカウント登録後
  def after_sign_up_path_for(resource)
    users_sign_up_complete_path(resource)
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  #ユーザー情報編集後
  def after_update_path_for(_resource)
    root_path
  end

  def configure_account_update_params
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
      :job])
  end
  
end
