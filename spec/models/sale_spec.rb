require 'rails_helper'

RSpec.describe Sale, type: :model do
  context "Validations" do
    it { should validate_presence_of(:date) }

    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code).is_at_most(50) }
    describe do
      before { @currency = Currency.create! name: "Soles", code: "SOLES", sign: "S/", rate: 1 }
      subject { build(:sale, code: 127823, currency_id: @currency.id, rate: @currency.rate, real_amount: 0, box_amount: 0, box_all_amount: 0) }
      it { should validate_uniqueness_of(:code).case_insensitive }
    end

    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(300) }

    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:currency) }
  end

  context "Relationships" do
    it { should belong_to(:currency) }
    it { should belong_to(:employee) }
  end
end
