require 'rails_helper'

RSpec.describe Employee, type: :model do
  context "Validations" do
    it { should validate_presence_of(:doc) }
    it { should validate_length_of(:doc).is_equal_to(8) }

    it { should validate_presence_of(:names) }
    it { should validate_length_of(:names).is_at_most(100) }

    it { should validate_presence_of(:last_names) }
    it { should validate_length_of(:last_names).is_at_most(100) }

    it { should validate_presence_of(:birth_date) }
  end

  context "Relationships" do
    it { should have_many(:sales) }
    it { should have_many(:spendings) }
  end
end
