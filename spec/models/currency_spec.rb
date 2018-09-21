require 'rails_helper'

RSpec.describe Currency, type: :model do
  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:sign) }
    it { should validate_length_of(:sign).is_at_most(20) }
    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code).is_at_most(20) }
    it { should validate_presence_of(:rate) }
    it { should validate_numericality_of(:rate).is_greater_than(0) }
  end

  context "Relationships" do
    it { should have_many(:sales) }
    it { should have_many(:spendings) }
  end
end
