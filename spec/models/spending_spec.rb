require 'rails_helper'

RSpec.describe Spending, type: :model do
  context "Validations" do
    it { should validate_presence_of(:date) }

    it { should validate_presence_of(:code) }
    it { should validate_inclusion_of(:code).in_array(Spending::CODES.map {|item| item[:code]}) }

    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }

    it { should validate_length_of(:description).is_at_most(300) }

    it { should validate_presence_of(:currency) }
    context "if Payroll" do
      before { subject.code = "2" }
      it { should validate_presence_of(:employee) }
    end

    context "if not Payroll" do
      before { subject.code = "1" }
      it { should_not validate_presence_of(:employee) }
    end
  end

  context "Relationships" do
    it { should belong_to(:currency) }
    it { should belong_to(:employee) }
  end
end
