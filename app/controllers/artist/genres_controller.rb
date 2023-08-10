class Artist::GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @genre_portfolios = @genre.portfolios.order("created_at DESC").page(params[:page]).per(15)
  end
end
