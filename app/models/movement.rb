class Movement < ApplicationRecord
  belongs_to :currency
  belongs_to :employee, optional: true

  def sale?
    type == "Sale"
  end

  def spending?
    type == "Spending"
  end

  def set_rate
    if self.currency
      self.rate = self.currency.rate
    end
  end

  def set_real_amount
    if self.amount && self.currency
      self.real_amount = self.amount * self.rate
    end
  end

  def set_box_amounts
    current_amount = Sale.where(currency_id: currency_id).sum(:amount) - Spending.where(currency_id: currency_id).sum(:amount)
    current_all_amount = Sale.where(currency_id: currency_id).sum(:real_amount) - Spending.where(currency_id: currency_id).sum(:real_amount)
    self.box_amount = set_box_amount(current_amount)
    self.box_all_amount = set_box_all_amount(current_all_amount)
  end

  def serializable_hash options=nil
    super.merge "type" => type
  end
end
