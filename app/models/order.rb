class Order < ApplicationRecord
    has_many :order_details
    belongs_to :user
    
    # enum status: { 
    #     "waiting_payment": 1,
    #     "confirm_payment": 2,
    #     "shipped": 3,
    #     "out_of_delivery": 4,
    #     "delivered": 5
    # }
    has_many :order_details, dependent: :destroy
end
