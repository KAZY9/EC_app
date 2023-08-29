class Order < ApplicationRecord
    has_many :order_details, dependent: :destroy
    belongs_to :user

    enum :payment_method, {
        "クレジット決済": 1,
        "代金引換": 2
    }
    
    enum :status, { 
        "支払待ち": 1,
        "支払済み": 2,
        "発送済み": 3,
        "配送中": 4,
        "配送完了": 5
    }
end
