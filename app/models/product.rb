class Product < ApplicationRecord
    scope :ordered, -> { order(name: :asc) }

    has_many :product_orders, dependent: :destroy
    has_many :orders, through: :product_orders

    validates :name, presence: true
    validates :price, :balance, numericality: { greater_than_or_equal_to: 0 }
end
