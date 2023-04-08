class User < ApplicationRecord
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

  #都道府県コードから都道府県名に変換
  include JpPrefecture
  jp_prefecture :prefecture_code
         
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
         
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def postal_code_with_mark
    "〒" + postal_code.to_s
  end

  private

  #パスワードは半角英数字記号含め8〜32文字で設定する
  def password_complexity
    if password.present? and not password.match(/\A(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[ -~]{8,32}\z/)
      errors.add :password, "は半角英数字記号を含め、8〜32文字で設定してください"
    end
  end
end
