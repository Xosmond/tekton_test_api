class Employee < ApplicationRecord
  paginates_per 10
  has_many :sales
  has_many :spendings

  validates :doc, presence: true, length: { is: 8 }
  validates :names, presence: true, length: { maximum: 100 }
  validates :last_names, presence: true, length: { maximum: 100 }
  validates :birth_date, presence: true

  def full_name
    self.names + ", " + self.last_names
  end

  def active
    !exit_date.nil?
  end
end
