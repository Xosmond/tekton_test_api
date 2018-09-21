require "rails_helper"

RSpec.describe CurrenciesController, type: :controller do
  before do
    @currency = create(:currency)
  end

  describe "GET #index" do
    it "renders a list of currencies" do
      get :index
      expect(response.body).to eq({currencies: [@currency], count: 1}.to_json)
    end
  end

  describe "GET #show" do
    context "with valid id" do
      it "renders the currency" do
        get :show, params: {id: @currency.id}
        expect(response.body).to eq({currency: @currency}.to_json)
      end
    end
    context "with invalid id" do
      it "returns 404" do
        expect {
          get :show, params: {id: "x"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new currency in the database" do
        expect{
          post :create, params: {currency: attributes_for(:currency)}
        }.to change(Currency,:count).by(1)
      end
      it "renders the new currency" do
        post :create, params: {currency: attributes_for(:currency)}
        expect(response.body).to eq({currency: Currency.last}.to_json)
      end
    end

    context "with invalid attributes" do
      it "does not saves the new currency in the database" do
        expect{
          post :create, params: {currency: {names: nil}}
        }.to change(Currency,:count).by(0)
      end
      it "returns 400 status" do
        post :create, params: {currency: {names: nil}}
        expect(response.status).to eq(400)
      end
      it "returns the errors" do
        post :create, params: {currency: {names: nil}}
        expect(JSON.parse(response.body)["errors"].symbolize_keys).not_to be_nil
      end
    end
  end

  describe "PUT #update" do
    context "with valid id" do
      context "with valid attributes" do
        it "update the currency" do
          new_attributes = attributes_for(:currency)
          put :update, params: {id: @currency.id, currency: new_attributes}
          @currency.reload
          expect(@currency.name).to eq(new_attributes[:name])
          expect(@currency.code).to eq(new_attributes[:code])
          expect(@currency.sign).to eq(new_attributes[:sign])
          expect(@currency.rate).to eq(BigDecimal.new(new_attributes[:rate]))
        end

        it "renders the currency" do
          put :update, params: {id: @currency.id, currency: attributes_for(:currency)}
          @currency.reload
          expect(response.body).to eq({currency: @currency}.to_json)
        end
      end

      context "with invalid attributes" do
        it "returns 400 status" do
          put :update, params: {id: @currency.id, currency: {name: nil}}
          expect(response.status).to eq(400)
        end
        it "returns the errors" do
          put :update, params: {id: @currency.id, currency: {name: nil}}
          expect(JSON.parse(response.body)["errors"].symbolize_keys).not_to be_nil
        end
      end
    end

    context "with invalid id" do
      it "returns 404" do
        expect {
          put :update, params: {id: "x"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid id" do
      it "destroys the currency" do
        expect{
          delete :destroy, params: {id: @currency.id}
        }.to change(Currency,:count).by(-1)
      end
      it "returns 200 status" do
        delete :destroy, params: {id: @currency.id}
        expect(response.status).to eq(200)
      end
    end
    context "with invalid id" do
      it "returns 404" do
        expect {
          delete :destroy, params: {id: "x"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
