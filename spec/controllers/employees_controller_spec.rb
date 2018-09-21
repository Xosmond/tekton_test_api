require "rails_helper"

RSpec.describe EmployeesController, type: :controller do
  before do
    @employee = create(:employee)
  end

  describe "GET #index" do
    it "renders a list of employees" do
      get :index
      expect(response.body).to eq({employees: [@employee], count: 1}.to_json)
    end
  end

  describe "GET #show" do
    context "with valid id" do
      it "renders the employee" do
        get :show, params: {id: @employee.id}
        expect(response.body).to eq({employee: @employee}.to_json)
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
      it "saves the new employee in the database" do
        expect{
          post :create, params: {employee: attributes_for(:employee)}
        }.to change(Employee,:count).by(1)
      end
      it "renders the new employee" do
        post :create, params: {employee: attributes_for(:employee)}
        expect(response.body).to eq({employee: Employee.last}.to_json)
      end
    end

    context "with invalid attributes" do
      it "does not saves the new employee in the database" do
        expect{
          post :create, params: {employee: {names: nil}}
        }.to change(Employee,:count).by(0)
      end
      it "returns 400 status" do
        post :create, params: {employee: {names: nil}}
        expect(response.status).to eq(400)
      end
      it "returns the errors" do
        post :create, params: {employee: {names: nil}}
        expect(JSON.parse(response.body)["errors"].symbolize_keys).not_to be_nil
      end
    end
  end

  describe "PUT #update" do
    context "with valid id" do
      context "with valid attributes" do
        it "update the employee" do
          new_attributes = attributes_for(:employee)
          put :update, params: {id: @employee.id, employee: new_attributes}
          @employee.reload
          expect(@employee.doc).to eq(new_attributes[:doc])
          expect(@employee.names).to eq(new_attributes[:names])
          expect(@employee.last_names).to eq(new_attributes[:last_names])
          expect(@employee.birth_date).to eq(new_attributes[:birth_date])
        end

        it "renders the employee" do
          put :update, params: {id: @employee.id, employee: attributes_for(:employee)}
          @employee.reload
          expect(response.body).to eq({employee: @employee}.to_json)
        end
      end

      context "with invalid attributes" do
        it "returns 400 status" do
          put :update, params: {id: @employee.id, employee: {names: nil}}
          expect(response.status).to eq(400)
        end
        it "returns the errors" do
          put :update, params: {id: @employee.id, employee: {names: nil}}
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
      it "destroys the employee" do
        expect{
          delete :destroy, params: {id: @employee.id}
        }.to change(Employee,:count).by(-1)
      end
      it "returns 200 status" do
        delete :destroy, params: {id: @employee.id}
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
