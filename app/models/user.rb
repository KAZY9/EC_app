class User < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :card, dependent: :destroy
  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  VALID_TEL_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :username, presence: true
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street_and_others, presence: true
  validates :tel, presence: true, format: { with: VALID_TEL_REGEX }
  validate :password_complexity
  validates_acceptance_of :agreement, allow_nil: false, on: :create
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable


  #パスワードなしでユーザー情報編集可能にする
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  private

  #パスワードは半角英数字特殊記号含め8〜32文字で設定する
  def password_complexity
    if password.present? and not password.match(/\A(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[ -~]{8,32}\z/)
      errors.add :password, "は半角英数字特殊記号を含め、8〜32文字で設定してください"
    end
  end
end
