class Order < ApplicationRecord
    has_many :order_details, dependent: :destroy
    belongs_to :user

    enum :payment_method, {
        "クレジット決済": 1,
        "代金引換": 2
    }
    
    enum :status, { 
        waiting_payment: 1,
        confirmed_payment: 2,
        shipped: 3,
        out_of_delivery: 4,
        delivered: 5
    }
end
