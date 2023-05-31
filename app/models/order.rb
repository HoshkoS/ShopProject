class Order < ApplicationRecord
    has_many :product_orders, dependent: :destroy
    has_many :products, through: :product_orders

    validates :first_name, :last_name, :address, :phone, presence: true
end
