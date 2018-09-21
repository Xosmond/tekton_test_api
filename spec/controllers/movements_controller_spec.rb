require "rails_helper"

RSpec.describe MovementsController, type: :controller do
  before do
    @currency = Currency.create! name: "Soles", code: "SOLES", sign: "S/", rate: 1
    params = attributes_for(:sale, type: "Sale", currency_id: @currency.id)
    @movement = Movement.new params
    @movement.set_rate
    @movement.set_real_amount
    @movement.set_box_amounts
    @movement.save!
  end

  describe "GET #index" do
    it "renders a list of movements" do
      get :index
      expect(response.body).to eq({movements: [JSON.parse(@movement.to_json(include: :currency))], count: 1}.to_json)
    end
  end

  describe "POST #sale" do
    context "with valid attributes" do
      it "saves the new sale in the database" do
        expect{
          post :sale, params: {sale: attributes_for(:sale, currency_id: @currency.id)}
        }.to change(Movement,:count).by(1)
      end
      it "renders the new sale" do
        post :sale, params: {sale: attributes_for(:sale, currency_id: @currency.id)}
        expect(response.body).to eq({movement: Sale.last}.to_json)
      end
    end
    context "with invalid attributes" do
      it "does not save the new sale in the database" do
        expect{
          post :sale, params: {sale: {amount: nil}}
        }.to change(Movement,:count).by(0)
      end
      it "returns 400 status" do
        post :sale, params: {sale: {amount: nil}}
        expect(response.status).to eq(400)
      end
      it "returns the errors" do
        post :sale, params: {sale: {amount: nil}}
        expect(JSON.parse(response.body)["errors"].symbolize_keys).not_to be_nil
      end
    end
  end

  describe "POST #spending" do
    context "with valid attributes" do
      it "saves the new spending in the database" do
        expect{
          attributes = attributes_for(:spending, currency_id: @currency.id)
          if attributes[:code] == "2"
            attributes[:employee_id] = create(:employee).id
          end
          post :spending, params: {spending: attributes}
        }.to change(Movement,:count).by(1)
      end
      it "renders the new sale" do
        attributes = attributes_for(:spending, currency_id: @currency.id)
        if attributes[:code] == "2"
          attributes[:employee_id] = create(:employee).id
        end
        post :spending, params: {spending: attributes}
        expect(response.body).to eq({movement: Spending.last}.to_json)
      end
    end
    context "with invalid attributes" do
      it "does not save the new spending in the database" do
        expect{
          post :spending, params: {spending: {amount: nil}}
        }.to change(Movement,:count).by(0)
      end
      it "returns 400 status" do
        post :spending, params: {spending: {amount: nil}}
        expect(response.status).to eq(400)
      end
      it "returns the errors" do
        post :spending, params: {spending: {amount: nil}}
        expect(JSON.parse(response.body)["errors"].symbolize_keys).not_to be_nil
      end
    end
  end
end
