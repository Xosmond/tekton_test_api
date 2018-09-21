class MovementsController < ApplicationController
  def index
    movements = Movement.all.order(created_at: :desc).page params[:page]
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
