class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]
  def index
    employees = Employee.all.page params[:page]
    render json: { employees: employees, count: Employee.count }
  end

  def all
    employees = Employee.all
    render json: { employees: employees }
  end

  def show
    render json: { employee: @employee }
  end

  def create
    employee = Employee.new employee_params
    if employee.save
      render json: { employee: employee }
    else
      render json: { errors: employee.errors }, status: 400
    end
  end

  def update
    if @employee.update employee_params
      render json: { employee: @employee }
    else
      render json: { errors: @employee.errors }, status: 400
    end
  end

  def destroy
    if @employee.spendings.count == 0
      if @employee.destroy
        head 200
      else
        render json: {errors: @employee.errors}, status: 400
      end
    else
      @employee.errors["General"] << "This employee has payrolls already relationed."
      render json: {errors: @employee.errors}, status: 400
    end
  end

  def set_employee
    @employee = Employee.find(params[:id])
    not_found unless @employee
  end

  def employee_params
    params.require(:employee).permit(:doc, :names, :last_names, :birth_date, :admission_date)
  end
end
