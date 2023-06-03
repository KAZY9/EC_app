class Product < ApplicationRecord
    with_options presence: true do
        validates :name
        validates :description
        validates :price
        validates :stock
        validates :color
        validates :images
    end
    has_many_attached :images
end
