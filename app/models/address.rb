class Address < ApplicationRecord
  belongs_to :user
  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  VALID_TEL_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :name, presence: true
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street_and_others, presence: true
  validates :tel, presence: true, format: { with: VALID_TEL_REGEX }

end
