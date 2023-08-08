class Artist::PortfolioBookmarksController < ApplicationController

  def show
    @gallary = current_gallary
    @bookmarks= PortfolioBookmark.where(gallary_id: @gallary.id)
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_bookmark = current_gallary.portfolio_bookmarks.create(portfolio_id: @portfolio.id)
    @portfolio_bookmark.save
  end

  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_bookmark = current_gallary.portfolio_bookmarks.find_by(portfolio_id: @portfolio.id)
    @portfolio_bookmark.destroy
  end
end
