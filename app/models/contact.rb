class Contact < ApplicationRecord
    VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
    VALID_TEL_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
    validates :name, presence: true
    validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX }, allow_blank: true
    validates :tel, format: { with: VALID_TEL_REGEX }, allow_blank: true
    validates :email, presence: true
    validates :subject, presence: true, length: { maximum: 100 }
    validates :message, presence: true, length: { maximum: 1000 }
end
