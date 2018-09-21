class Sale < Movement
  validates :date, presence: true
  validates :code, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :amount, presence: true
  validates :currency, presence: true

  def set_box_amount(current_amount)
    current_amount + self.amount
  end

  def set_box_all_amount(current_all_amount)
    current_all_amount + self.real_amount
  end
end
