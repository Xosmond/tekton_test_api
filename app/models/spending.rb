class Spending < Movement
  CODES = [{code: "1", name: "Purchases"},{code: "2", name: "Payroll"},{code: "3", name: "Administrative expenses"},{code: "4", name: "Others"}]

  validates :date, presence: true
  validates :code, presence: true, inclusion: { in: proc {CODES.map {|item| item[:code]}}, message: "%{value} is not a valid size" }
  validates :description, length: { maximum: 300 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validates :employee, presence: true, if: :is_payroll?

  def is_payroll?
    code == "2"
  end

  def set_box_amount(current_amount)
    current_amount - self.amount
  end

  def set_box_all_amount(current_all_amount)
    current_all_amount - self.real_amount
  end
end
