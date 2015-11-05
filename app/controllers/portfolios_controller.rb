class PortfoliosController < ApplicationController
	before_action :set_portfolio, only: [:show, :edit, :update, :destroy]

  def show
	end

	def new
    @portfolio = Portfolio.new
    @portfolio.stocks.build
    @stocks = Stock.all
  end

  def update
    # @portfolio = Portfolio
    @portfolio.portfolio_stocks.new
	end

  def edit
  end

  def destroy
  end

	def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    @portfolio.user_id = current_user.id
    if portfolio.save
      respond_with(@portfolio)
    else
      render :new
    end
	end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:name, :cash, :user_id)
  end
end
