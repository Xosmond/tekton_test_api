class Currency < ApplicationRecord
  has_many :sales
  has_many :spendings
  validates :name, presence: true, length: { maximum: 100 }
  validates :code, presence: true, length: { maximum: 20 }
  validates :sign, presence: true, length: { maximum: 20 }
  validates :rate, presence: true, numericality: { greater_than: 0 }
end
