class Artist::PortfoliosController < ApplicationController
  def index
     @portfolios = Portfolio.order(create_at: :DESC).page(params[:page])
  end
  
  def new
    @portfolio = Portfolio.new
  end
  
  def create
    @portfolio = Portfolio.new(portfolio_params)
    
    if @portfolio.save
      @portfolio.artist_id = current_artist.id
      redirect_to portfolios_path
    else
      flash[:alert] = "データを保存できませんでした。"
      redirect_to new_portfolio_path
    end
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    @portfolio.update(portfolio_params)
    redirect_to portfolio_path(@portfolio.id)
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    redirect_to portfolios_path
  end
  
  private
  
  def portfolio_params
    params.require(:portfolio).permit( :artist_id, :title, :item, :introduction, :image)
  end
end
