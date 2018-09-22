class Api::V1::MovementsController < ApplicationController
  def index
    if params[:start] && params[:end]
      start_date = params[:start].to_datetime.start_of_day
      end_date = params[:end].to_datetime.end_of_day
      movements = Movement.where(created_at: start_date..end_date).order(created_at: :desc).page params[:page]
    else
      movements = Movement.all.order(created_at: :desc).page params[:page]
    end
    render json: { movements: JSON.parse(movements.to_json(include: :currency)), count: Movement.count }
  end

  def sale
    @movement = Sale.new sale_params
    create
  end

  def spending
    @movement = Spending.new spending_params
    create
  end

  def spending_codes
    render json: {codes: Spending::CODES}
  end

  private
  def create
    if @movement.valid?
      @movement.set_rate
      @movement.set_real_amount
      @movement.set_box_amounts
      if @movement.save
        render json: { movement: @movement }
      else
        head 500
      end
    else
      render json: { errors: @movement.errors }, status: 400
    end
  end

  def sale_params
    params.require(:sale).permit(:date, :code, :description, :amount, :currency_id, :employee_id)
  end

  def spending_params
    params.require(:spending).permit(:date, :code, :description, :amount, :currency_id, :employee_id)
  end
end
