class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :update, :destroy]
  def index
    currencies = Currency.all.page params[:page]
    render json: { currencies: currencies, count: Currency.count }
  end

  def all
    currencies = Currency.all
    render json: { currencies: currencies }
  end

  def show
    render json: { currency: @currency }
  end

  def create
    currency = Currency.new currency_params
    if currency.save
      render json: { currency: currency }
    else
      render json: { errors: currency.errors }, status: 400
    end
  end

  def update
    if @currency.update currency_params
      render json: { currency: @currency }
    else
      render json: { errors: @currency.errors }, status: 400
    end
  end

  def destroy
    if @currency.sales.count == 0 && @currency.spendings.count == 0
      if @currency.destroy
        head 200
      else
        render json: {errors: @currency.errors}, status: 400
      end
    else
      @currency.errors["General"] << "This currency has movements already relationed."
      render json: {errors: @currency.errors}, status: 400
    end
  end

  def set_currency
    @currency = Currency.find(params[:id])
    not_found unless @currency
  end

  def currency_params
    params.require(:currency).permit(:name, :code, :sign, :rate)
  end
end
